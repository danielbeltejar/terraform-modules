resource "kubernetes_namespace" "namespace" {
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
    labels = {
      "environment" = each.value.name
      "secured"     = tostring(each.value.secured)
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "kubernetes_service_account" "default_service_account" {
  for_each = { for ns in local.namespaces_with_defaults : ns.name => ns if ns.secured }

  metadata {
    name      = "default"
    namespace = each.value.name
  }

  automount_service_account_token = false
}