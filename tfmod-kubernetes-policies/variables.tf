variable "policies" {
  type = map(object({
    name   = string
    policy = string
    api_groups = optional(string, "[]")
    kinds = optional(string, "[\"Pod\"]")
    excluded_namespaces = optional(string, "[\"kube-*\", \"*-system\", \"cert-manager\", \"ingress-nginx\", \"*-pihole\", \"*-jenkins\", \"monitoring\", \"lab-wireguard\"]")
  }))
}

