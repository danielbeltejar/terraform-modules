module "kubernetes_namespaces_test" {
  source = "../../"  

  namespaces = [
    {
      name    = "test-sa-automount"
    },
    {
      name    = "test"
      automount_service_account = false
    }
  ]
}
