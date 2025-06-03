variable "policies" {
  type = map(object({
    name                = string
    policy              = string
    api_groups          = optional(list(string), "[]")
    kinds               = optional(list(string), ["Pod"])
    excluded_namespaces = optional(list(string), ["kube-*", "*-system", "cert-manager", "ingress-nginx", "*-pihole", "*-jenkins", "monitoring", "lab-wireguard", "lab-openclarity"])
  }))
}

