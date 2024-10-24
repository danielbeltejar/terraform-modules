locals {
  namespaces_with_defaults = [
    for ns in var.namespaces : merge(ns, {
      automount_service_account = lookup(ns, "automount_service_account", false)
    })
  ]
}