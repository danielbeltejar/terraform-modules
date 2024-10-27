variable "namespaces_policies" {
  type = list(object({
    front_namespace  = string
    back_namespace   = string
    allow_back_hosts = optional(list(string), [])
  }))
}

