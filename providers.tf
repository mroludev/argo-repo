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
  config_path = file("/home/ubuntu/.kube/config")
  host                   = local.host
  token                  = local.decoded_token
  cluster_ca_certificate = local.decoded_certificate
  client_certificate     = local.decoded_certificate
  client_key             = local.decoded_client_key
  
}

provider "kubectl" {
  config_path = file("/home/ubuntu/.kube/config")
  
  load_config_file       = true
}


provider "helm" {
  host                   = local.host
  token                  = local.decoded_token
  cluster_ca_certificate = local.decoded_certificate
  client_certificate     = local.decoded_certificate
  client_key             = local.decoded_client_key
}


locals {
  host        = output.kubernetes_master_endpoint.value
  certificate = file("/home/ubuntu/k8scert/ca.crt")
  token       = file("/home/ubuntu/k8scert/token.txt")
  client_key  = file("/home/ubuntu/k8scert/client_key.txt")

  decoded_certificate = base64decode(local.certificate)
  decoded_token       = base64decode(local.token)
  decoded_client_key  = base64decode(local.client_key)
  load_config_file       = true
}
