module "network" {
  source = "../../modules/network"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = var.network_resource_group_name
  tags                = var.tags
}

module "storage" {
  source = "../../modules/storage"

  name                = var.storage_account_name
  location            = var.location
  resource_group_name = var.storage_resource_group_name
  tags                = var.tags
}

module "database" {
  source = "../../modules/database"

  server_name         = var.sql_server_name
  database_name       = var.sql_database_name
  location            = var.location
  resource_group_name = var.sql_resource_group_name
  aad_admin_username  = var.sql_aad_admin_username
  aad_admin_object_id = var.sql_aad_admin_object_id
  tags                = var.tags
}

module "sql_private_endpoint" {
  source = "../../modules/network/private-endpoint"

  name                           = var.sql_private_endpoint_name
  location                       = var.location
  resource_group_name            = var.network_resource_group_name
  subnet_id                      = module.network.private_endpoint_subnet_id
  vnet_id                        = module.network.vnet_id
  mgmt_vnet_id                   = module.network.mgmt_vnet_id
  management_dns_link_name       = "mgmt-vnet-link"
  private_connection_resource_id = module.database.sql_server_id
  subresource_names              = ["sqlServer"]
  private_dns_zone_name          = "privatelink.database.windows.net"
  tags                           = var.tags
}

module "storage_private_endpoint" {
  source = "../../modules/network/private-endpoint"

  name                           = var.storage_private_endpoint_name
  location                       = var.location
  resource_group_name            = var.network_resource_group_name
  subnet_id                      = module.network.private_endpoint_subnet_id
  vnet_id                        = module.network.vnet_id
  private_connection_resource_id = module.storage.storage_account_id
  subresource_names              = ["blob"]
  private_dns_zone_name          = "privatelink.blob.core.windows.net"
  tags                           = var.tags
}
