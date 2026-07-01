resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location

  version                      = "12.0"

  azuread_administrator {
    login_username = var.aad_admin_username
    object_id      = var.aad_admin_object_id

    azuread_authentication_only = true

  }
   identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = var.database_name
  server_id = azurerm_mssql_server.this.id

  sku_name = "GP_S_Gen5_2"
storage_account_type = "Local"
  tags = var.tags
}