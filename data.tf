# Cluster data
#data "aws_eks_cluster" "cluster" {
#   name = "kubernetes-admin@kubernetes"
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = "kubernetes-admin@kubernetes"
#}

data "kubectl_file_documents" "crds" {
  content = file("olm/crds.yaml")
}
data "kubectl_file_documents" "olm" {
  content = file("olm/olm.yaml")
}
data "kubectl_config" "current" {}



# Namespace
data "kubectl_file_documents" "namespace" {
  content = file("/home/ubuntu/argo-repo/manifests/namespace.yaml")
}

# Argo CRD installation
data "kubectl_file_documents" "argocd" {
  content = file("/home/ubuntu/argo-repo/manifests/install.yaml")
}

# Argo svc
data "kubectl_file_documents" "svc" {
  content = file("${path.module}/manifests/service.yaml")
}

# Repos secrets
data "kubectl_file_documents" "emart-secret" {
  content = file("${path.module}/manifests/secretemart.yaml")
}

 data "kubectl_file_documents" "micros-secret" {
   content = file("${path.module}/manifests/secretmicros.yaml")
 }
data "kubectl_file_documents" "wordpress-secret" {
   content = file("${path.module}/manifests/secretwordpress.yaml")
 }
data "kubectl_file_documents" "mysql-secret" {
   content = file("${path.module}/manifests/secretmysql.yaml")
 }

# Repos
data "kubectl_file_documents" "emart" {  
  content = file("${path.module}/manifests/emart.yaml")  # replace with emart
}

data "kubectl_file_documents" "micros" {
  content = file("${path.module}/manifests/micros.yaml")  # replace with micros
}


data "kubectl_file_documents" "wordpress" {
  content = file("${path.module}/manifests/wordpress.yaml")  # replace with micros
}

data "kubectl_file_documents" "mysql" {
  content = file("${path.module}/manifests/mysql.yaml")  # replace with micros
}
# add the microservice here

# add the emart here

# add the wordpress here

# add the istio here