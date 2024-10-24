module "kubernetes_namespaces_test" {
  source = "../../"  

  namespaces = [
    {
      name    = "test-sa-automount"
      automount_service_account = true
    },
    {
      name    = "test"
    }
  ]
}
