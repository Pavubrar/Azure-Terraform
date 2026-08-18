resource "azurerm_container_app_job" "migration" {

  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location

  container_app_environment_id = var.container_app_environment_id

  replica_timeout_in_seconds = 1800
  replica_retry_limit        = 1

  manual_trigger_config {
    parallelism              = 1
    replica_completion_count = 1
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  registry {
    server   = var.registry_server
    identity = var.identity_id
  }

  template {

    container {

      name   = "migration"
      image  = var.image

      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "RunMigrations"
        value = "true"
      }

      env {
        name  = "ConnectionStrings__DefaultConnection"
        value = var.sql_connection_string
      }

      env {
        name  = "AZURE_CLIENT_ID"
        value = var.azure_client_id
      }
    }
  }
}
