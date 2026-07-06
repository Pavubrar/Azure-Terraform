
# module "resource_group" {
#   source = "../../modules/resource_group"

#   name     = var.resource_group_name
#   location = var.location

#   tags = {
#     environment = var.environment
#     owner       = var.owner
#   }
# }

module "app_service" {
  source = "../../modules/app_service"

  app_name            = var.backend_app_name
  service_plan_name   = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  service_plan_id = var.service_plan_id
  app_subnet_id = module.network.app_subnet_id
}

module "frontend" {
  source = "../../modules/app_service"

  app_name            = var.frontend_app_name
  service_plan_name   = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  service_plan_id = var.service_plan_id
   
}
module "storage" {
  source = "../../modules/storage"

  name                = var.storageAcc_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# module "key_vault" {
#   source = "../../modules/key_vault"

#   name                = "kv-prod"
#   resource_group_name = "rg-prod"
#   location            = "Canada Central"
#   tenant_id           = var.tenant_id
# }

module "database" {
  source = "../../modules/database"

  server_name         = "bookshelf"
  resource_group_name = "BookApp"
  database_name       = "free-sql-db-3528898"
  location            = "Canada Central"

  aad_admin_username  = "admin@MngEnvMCAP517100.onmicrosoft.com"
  aad_admin_object_id = "d10c1b64-74e2-4205-b3af-6d24d28ca6c8"
}


module "network" {
  source = "../../modules/network"

  vnet_name          = "dev-vnet"
  resource_group_name = "DevOps"
  location           = "Canada Central"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
#-----Private endpoint for SQL---#
module "sql_private_endpoint" {
  source = "../../modules/network/private-endpoint"

  name                = "sql-pep"
  location            = "Canada Central"
  resource_group_name = "DevOps"

  subnet_id = module.network.private_endpoint_subnet_id
  vnet_id   = module.network.vnet_id

  private_connection_resource_id = module.database.sql_server_id

  subresource_names = ["sqlServer"]

  private_dns_zone_name = "privatelink.database.windows.net"

  tags = {
    environment = "dev"
  }
}


# =========== simple boiler plate kind of setup to create rg and web app i azure app services"
# module "resource_group" {
#   source = "./modules/resource_group"

#   name     = var.resource_group_name
#   location = var.location

#   tags = {
#     environment = var.environment
#     owner       = var.owner
#   }
# }
# module "app_service" {
#   source = "./modules/app_service"

#   app_name            = var.app_name
#   service_plan_name   = var.service_plan_name
#   location            = var.location
#   resource_group_name = module.resource_group.resource_group_name
#   sku_name            = "B1"
# }
