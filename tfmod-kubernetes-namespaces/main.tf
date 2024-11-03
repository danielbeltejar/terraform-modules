resource "kubernetes_namespace" "namespace" {
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
    labels = {
      "disable_automount_service_account"     = tostring(each.value.disable_automount_service_account)
    }
    annotations = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }
  }


  lifecycle {
    prevent_destroy = true
  }
}

resource "kubernetes_default_service_account" "default_service_account" {
  for_each = { for ns in local.disable_automount_service_account : ns.name => ns if ns.automount_service_account }

  metadata {
    name      = "default"
    namespace = each.value.name
  }

  automount_service_account_token = false
}
