resource "kubectl_manifest" "templates_gatekeeper" {
  for_each  = var.policies
  yaml_body = yamlencode({
    apiVersion = "templates.gatekeeper.sh/v1"
    kind       = "ConstraintTemplate"
    metadata = {
      name = lower(each.key)
    }
    spec = {
      crd = {
        spec = {
          names = {
            kind = each.key
          }
        }
      }
      targets = [
        {
          target = "admission.k8s.gatekeeper.sh"
          rego   = each.value.policy
        }
      ]
    }
  })
}

resource "kubectl_manifest" "constraints_gatekeeper" {
  for_each = var.policies
  yaml_body = <<EOF
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: ${each.key}
metadata:
  name: ${lower(each.value.name)}
spec:
  match:
    kinds:
      - apiGroups: ${each.value.api_groups}
        kinds: ${each.value.kinds}
    excludedNamespaces: ["kube-*", "*-system", "cert-manager", "ingress-nginx"]
  EOF
}



terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
