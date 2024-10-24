variable "namespaces" {
  description = "List of namespaces with their names and automount_service_account status."
  type = list(object({
    name    = string
    automount_service_account = optional(bool, false)
  }))
  validation {
    condition = length(var.namespaces) > 0
    error_message = "At least one namespace must be provided."
  }
}
