# Namespace
resource "kubectl_manifest" "namespace" {
  for_each           = data.kubectl_file_documents.namespace.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

# Argo installation
resource "kubectl_manifest" "argocd" {
  depends_on = [
    kubectl_manifest.namespace,
  ]
  for_each           = data.kubectl_file_documents.argocd.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

# Argo SVC
resource "kubectl_manifest" "svc" {
  depends_on = [
    kubectl_manifest.argocd,
  ]
  for_each           = data.kubectl_file_documents.svc.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

# Repo secrets
resource "kubectl_manifest" "emart_repo" {
  depends_on = [
    kubectl_manifest.svc
  ]
  for_each           = data.kubectl_file_documents.emart-secret.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

 resource "kubectl_manifest" "micros_repo" {
   depends_on = [
     kubectl_manifest.svc
   ]
   for_each           = data.kubectl_file_documents.micros-secret.manifests
   yaml_body          = each.value
   override_namespace = "argocd"
 }
 resource "kubectl_manifest" "wordpress_repo" {
   depends_on = [
     kubectl_manifest.svc
   ]
   for_each           = data.kubectl_file_documents.wordpress-secret.manifests
   yaml_body          = each.value
   override_namespace = "argocd"
 }
resource "kubectl_manifest" "mysql_repo" {
   depends_on = [
     kubectl_manifest.svc
   ]
   for_each           = data.kubectl_file_documents.mysql-secret.manifests
   yaml_body          = each.value
   override_namespace = "argocd"
 }


# Repos
resource "kubectl_manifest" "emart" {
  depends_on = [
    kubectl_manifest.emart_repo
  ]
  for_each           = data.kubectl_file_documents.emart.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

resource "kubectl_manifest" "micros" {
  depends_on = [
    kubectl_manifest.micros_repo
  ]
  for_each           = data.kubectl_file_documents.micros.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}


resource "kubectl_manifest" "wordpress" {
  depends_on = [
    kubectl_manifest.wordpress_repo
  ]
  for_each           = data.kubectl_file_documents.wordpress.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

resource "kubectl_manifest" "mysql" {
  depends_on = [
    kubectl_manifest.mysql_repo
  ]
  for_each           = data.kubectl_file_documents.mysql.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}
