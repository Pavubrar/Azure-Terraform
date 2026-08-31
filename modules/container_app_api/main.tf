resource "azurerm_container_app" "api" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  registry {
    server   = var.registry_server
    identity = var.identity_id
  }

  template {
    min_replicas = 0
    max_replicas = 3
  container {
  name   = "bookshelf-api"
  image  = var.image
  cpu    = 0.5
  memory = "1Gi"

  startup_probe {
  transport = "HTTP"

  port = 8080
  path = "/live"

  interval_seconds = 10
  timeout          = 5

  failure_count_threshold = 10
}
readiness_probe {
  transport = "HTTP"

  port = 8080
  path = "/live"

  interval_seconds = 10
  timeout          = 5

  failure_count_threshold = 3
  success_count_threshold = 1
}
liveness_probe {
  transport = "HTTP"

  port = 8080
  path = "/live"

  interval_seconds = 30
  timeout          = 5

  failure_count_threshold = 3
}

  env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = "Production"
      }
  env {
    name  = "ConnectionStrings__DefaultConnection"
    value = var.sql_connection_string
  }
  env {
  name  = "RunMigrations"
  value = "false"
}

  env {
    name  = "Jwt__Issuer"
    value = "BookShelf.Api"
  }

  env {
    name  = "Jwt__Audience"
    value = "BookShelf.Web"
  }

  env {
    name  = "Jwt__Key"
    value = var.jwt_key
  }

  env {
    name  = "AzureStorage__AccountName"
    value = var.storage_account_name
  }

  env {
    name  = "AzureStorage__ContainerName"
    value = "uploads"
  }
  env { 
    name  = "AZURE_CLIENT_ID" 
    value = var.azure_client_id
    }
    env {
    name  = "Cors__AllowedOriginsCsv"
    value = "http://localhost:3000,http://localhost:5173"
}
 }

}

  ingress {
    external_enabled = true
    target_port      = 8080

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
