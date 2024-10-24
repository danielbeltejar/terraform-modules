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
      chart       = "nginx-stable/nginx-ingress"
      namespace   = "nginx"
      version     = "1.41.3"
      values_file = "./test-values.yaml"
    },
    {
      name        = "longhorn"
      chart       = "longhorn/longhorn"
      namespace   = "longhorn-system"
      version     = "1.4.0"
      values_file = "./test-values.yamls"
    }
  ]
}
