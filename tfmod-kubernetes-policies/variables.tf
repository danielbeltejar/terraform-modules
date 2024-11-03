variable "policies" {
  type = map(object({
    name   = string
    policy = string
    api_groups = optional(string, "[]")
    kinds = optional(string, "[\"Pod\"]")
  }))
}

