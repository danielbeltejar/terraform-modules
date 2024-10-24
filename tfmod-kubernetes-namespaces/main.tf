resource "kubernetes_namespace" "namespace" {
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
    labels = {
      "automount_service_account"     = tostring(each.value.automount_service_account)
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "kubernetes_service_account" "default_service_account" {
  for_each = { for ns in local.namespaces_with_defaults : ns.name => ns if ns.automount_service_account }

  metadata {
    name      = "default"
    namespace = each.value.name
  }

  automount_service_account_token = false
}
