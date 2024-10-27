terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  load_config_file = true
  config_path      = file("~/.kube/config")
}

module "network_policies" {
  source = "../.."

  namespaces_policies = [{
    front_namespace  = "pro-test-front"
    back_namespace   = "pro-test-back"
    allow_back_hosts = ["danielbeltejar.es", "github.com"]
  },
  {
    front_namespace = "pre-test-front"
    back_namespace = "pre-test-back"
  }]
}
