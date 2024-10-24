output "namespaces" {
  description = "Names of the created namespaces."
  value       = length(kubernetes_namespace.namespace) > 0 ? [for ns in kubernetes_namespace.namespace : ns.metadata[0].name] : []
}
