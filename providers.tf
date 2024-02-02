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
   config_path = file("~/.kube/config")
}

provider "kubectl" {
  config_path = file("~/.kube/config")
  context     = "kubernetes-admin@kubernetes"
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
  host = data.kubectl_config.current.current_context.0.cluster.0.cluster.server
}
output "host" {
  value = local.host
}

