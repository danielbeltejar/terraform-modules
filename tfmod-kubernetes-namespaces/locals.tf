locals {
  derived_namespaces = flatten([
    for ns_key, ns_value in var.namespaces : [
      ns_value.create_environments ? [
        ns_value.create_segregated ? [
          "pre-${ns_key}-front",
          "pre-${ns_key}-back",
          "pro-${ns_key}-front",
          "pro-${ns_key}-back"
          ] : [
          "pre-${ns_key}",
          "pro-${ns_key}"
        ]
      ] : [],
      !ns_value.create_environments && ns_value.create_segregated ? [
        "${ns_key}-front",
        "${ns_key}-back"
        ] : (!ns_value.create_environments && !ns_value.create_segregated ? [
          ns_key
      ] : [])
    ]
  ])

  disable_automount_service_account_namespaces = flatten([
    for ns_key, ns_value in var.namespaces :
    ns_value.disable_automount_service_account ?
    flatten([
      ns_value.create_environments ?
      (ns_value.create_segregated ?
        ["pre-${ns_key}-front", "pre-${ns_key}-back", "pro-${ns_key}-front", "pro-${ns_key}-back"] :
        ["pre-${ns_key}", "pro-${ns_key}"]
      ) : [],
      (!ns_value.create_environments && ns_value.create_segregated) ?
      ["${ns_key}-front", "${ns_key}-back"] :
      [ns_key]
    ]) : []
  ])
}
