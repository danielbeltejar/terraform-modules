module "policies" {
  source = "../.."

  policies = {
    "K8sRequireUser" = {
      name   = "pods-must-not-run-as-root"
      policy = <<-EOF
package k8srequireuser

violation[{"msg": msg}] {
  input.review.object.spec.securityContext.runAsUser == 0
  msg := "Running as root (UID 0) is not allowed"
}
EOF  
    }
  }

}
