resource "kubectl_manifest" "frontend_policy" {
  for_each = local.namespaces_policies_map

  yaml_body = <<EOF
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "frontend-policy"
  namespace: "${each.value.front_namespace}"
spec:
  endpointSelector: {} 
  ingress:
    - fromEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: ingress-nginx
  egress:
    - toEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: kube-system
    - toPorts:
        - ports:
            - port: "53"
              protocol: "UDP"
          rules:
            dns:
              - matchPattern: '*'
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
  endpointSelector: {} 
  ingress:
    - fromEndpoints:
        - matchLabels:
            "kubernetes.io/metadata.name": "${each.value.front_namespace}" 
  egress:
    - toFQDNs:
${local.fqdn_entries[each.key]}
    - toEntities:
        - cluster
    - toPorts:
        - ports:
            - port: "53"
              protocol: "UDP"
          rules:
            dns:
              - matchPattern: '*'
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
