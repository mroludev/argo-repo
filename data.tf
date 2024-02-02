# Cluster data
data "aws_eks_cluster" "cluster" {
  name = "laflor-eks-b2ZGagy0"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "laflor-eks-b2ZGagy0"
}

# Namespace
data "kubectl_file_documents" "namespace" {
  content = file("${path.module}/manifests/namespace.yaml")
}

# Argo CRD installation
data "kubectl_file_documents" "argocd" {
  content = file("${path.module}/manifests/install.yaml")
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