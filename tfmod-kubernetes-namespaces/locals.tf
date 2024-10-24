locals {
  namespaces_with_defaults = [
    for ns in var.namespaces : merge(ns, {
      secured = lookup(ns, "secured", true)
    })
  ]
}