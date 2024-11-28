module "kubernetes_namespaces_test" {
  source = "../../"

  namespaces = {
    homepage = {
      disable_automount_service_account = true
      create_environments               = true
      create_segregated                 = true
    }
    api = {
      disable_automount_service_account = false
      create_environments               = false
      create_segregated                 = true
    }
    monitoring = {
      disable_automount_service_account = true
      create_environments               = true
      create_segregated                 = false
    }
    logs = {
      disable_automount_service_account = false
      create_environments               = false
      create_segregated                 = false
    }
  }
}
