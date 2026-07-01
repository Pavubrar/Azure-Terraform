resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version          = "TLS1_2"
   shared_access_key_enabled = false

  tags = var.tags

  # lifecyce to recover rg name diffrentiate devopsto DevOps
  lifecycle {
     ignore_changes = all  
     }
}