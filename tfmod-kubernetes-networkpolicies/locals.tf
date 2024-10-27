locals {
  namespaces_policies_map = { for idx, policy in var.namespaces_policies : idx => policy }

  fqdn_entries = {
    for idx, policy in local.namespaces_policies_map : idx => 
      length(policy.allow_back_hosts) > 0 ? join("\n", [
        for host in policy.allow_back_hosts : "      - matchName: \"${host}\""
      ]) : ""
  }
}