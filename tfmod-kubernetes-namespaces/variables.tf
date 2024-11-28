variable "namespaces" {
  description = "List of namespaces with their names and automount_service_account status."
  type = map(object({
    disable_automount_service_account = optional(bool, true)
    create_environments               = optional(bool, true) 
    create_segregated                 = optional(bool, true) 
  }))
  validation {
    condition     = length(var.namespaces) > 0
    error_message = "At least one namespace must be provided."
  }
}
