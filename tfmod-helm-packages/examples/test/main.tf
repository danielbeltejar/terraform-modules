provider "helm" {
  kubernetes {
    config_path = file("~/.kube/config")
  }
}

module "helm_packages" {
  source = "../../"

  kubeconfig = file("~/.kube/config")

  helm_charts = [
    {
      name        = "nginx"
      repository  = "nginx-stable/nginx-ingress"
      chart       = "nginx"
      namespace   = "nginx"
      version     = "1.41.3"
      values_file = "./test-values.yaml"
    },
    {
      name        = "longhorn"
      repository  = "longhorn/longhorn"
      chart       = "longhorn"
      namespace   = "longhorn-system"
      version     = "1.4.0"
      values_file = "./test-values.yaml"
      create_namespace = false
    }
  ]
}
