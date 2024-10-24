variable "namespaces" {
  description = "List of namespaces with their names and secured status."
  type = list(object({
    name    = string
    secured = optional(bool, true)
  }))
  validation {
    condition = length(var.namespaces) > 0
    error_message = "At least one namespace must be provided."
  }
}
