output "helm_releases" {
  description = "List of Helm releases installed."
  value = [for release in helm_release.packages : {
    name      = release.name
    namespace = release.namespace
    version   = release.version
  }]
}
