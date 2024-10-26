variable "kubeconfig" {
  description = "Path to the Kubernetes config file."
  type        = string
}

variable "helm_charts" {
  description = "List of Helm charts to be installed."
  type = list(object({
    name        = string
    repository  = string
    namespace   = string
    chart       = string
    version     = string
    values_file = string
    create_namespace = optional(string, true)
  }))
  validation {
    condition     = length(var.helm_charts) > 0
    error_message = "You must specify at least one Helm chart."
  }
}
