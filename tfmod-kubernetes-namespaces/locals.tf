locals {
  disable_automount_service_account = [
    for ns in var.namespaces : merge(ns, {
      automount_service_account = lookup(ns, "disable_automount_service_account", true)
    })
  ]
}