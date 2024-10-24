module "kubernetes_namespaces_test" {
  source = "../../"  

  namespaces = [
    {
      name    = "test-sa-automount"
      disable_automount_service_account = false
    },
    {
      name    = "test"
      disable_automount_service_account = true
    }
  ]
}
