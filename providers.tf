# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = ">= 1.13.11"
#     }
#   }
# }

# provider "aws" {
#   region = "us-west-2"
#   default_tags {
#     tags = {
#       Project = "eks-argoCd"
#       ManagedBy = "terraform"
#     }
#   }
#   }

# provider "kubernetes" {
#   host = local.host
#   cluster_ca_certificate = local.certificate
#   token = local.token
# }

# provider "kubectl" {
#   host = local.host
#   cluster_ca_certificate = local.certificate
#   token = local.token
#   load_config_file = false
# }

# provider "helm" {
#   host                   = local.host
#   cluster_ca_certificate = local.certificate
#   token                  = local.token
# }

# locals {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.cluster.token
# }

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.13.11"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "null" {
  # A null provider does nothing, it is used here to avoid errors related to missing providers.
}

provider "kubernetes" {
  host                   = local.host
  token                  = local.decoded_token
  cluster_ca_certificate = local.decoded_certificate
  client_certificate     = local.decoded_certificate
  client_key             = local.decoded_client_key
}

provider "kubectl" {
  host                   = local.host
  cluster_ca_certificate = local.certificate
  token                  = local.token
  load_config_file       = false
}

provider "helm" {
  host                   = local.host
  token                  = local.decoded_token
  cluster_ca_certificate = local.decoded_certificate
  client_certificate     = local.decoded_certificate
  client_key             = local.decoded_client_key
}

locals {
  host        = "192.168.64.12"
  certificate = "/k8scert/ca.crt"
  token       = "/k8scert/token.txt"
  client_key  = "/k8scert/client_key.txt"

  decoded_certificate = base64decode(file(local.certificate))
  decoded_token       = base64decode(file(local.token))
  decoded_client_key  = base64decode(file(local.client_key))
}

