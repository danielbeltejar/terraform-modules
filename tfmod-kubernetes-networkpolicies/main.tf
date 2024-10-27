resource "kubectl_manifest" "frontend_policy" {
  for_each = local.namespaces_policies_map

  yaml_body = <<EOF
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "frontend-policy"
  namespace: "${each.value.front_namespace}"
spec:
  endpointSelector: {} # Applies to all pods in the frontend namespace
  ingress:
    - fromEndpoints:
        - matchLabels:
            app: "nginx" # Allow traffic from Nginx ingress
  egress:
    - {} # Deny all egress traffic by default (no rules defined)
  policyTypes:
    - Ingress
    - Egress
EOF
}

resource "kubectl_manifest" "backend_policy" {
  for_each = local.namespaces_policies_map

  yaml_body = <<EOF
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "backend-policy"
  namespace: "${each.value.back_namespace}"
spec:
  endpointSelector: {} # Applies to all pods in the backend namespace
  ingress:
    - fromEndpoints:
        - matchLabels:
            "kubernetes.io/metadata.name": "${each.value.front_namespace}" # Allow traffic only from frontend namespace
  egress:
    - toFQDNs:
${local.fqdn_entries[each.key]} # Inject FQDN entries from allow_back_hosts
  policyTypes:
    - Ingress
    - Egress
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
