resource "kubernetes_namespace" "namespace" {
  for_each = toset(local.derived_namespaces)

  metadata {
    name = each.value
    annotations = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "kubernetes_default_service_account" "default_service_account" {
  for_each = toset(local.disable_automount_service_account_namespaces)

  metadata {
    name      = "default"
    namespace = each.value
  }

  automount_service_account_token = false
}
