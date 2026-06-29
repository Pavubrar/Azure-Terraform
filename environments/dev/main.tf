
module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

module "app_service" {
  source = "../../modules/app_service"

  app_name            = var.app_name
  service_plan_name   = var.service_plan_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
}

module "storage" {
  source = "../../modules/storage"

  name                = "mystorageprod"
  resource_group_name = "rg-prod"
  location            = "Canada Central"
}

module "key_vault" {
  source = "../../modules/key_vault"

  name                = "kv-prod"
  resource_group_name = "rg-prod"
  location            = "Canada Central"
  tenant_id           = var.tenant_id
}

module "database" {
  source = "../../modules/database"

  server_name         = "bookshelf"
  resource_group_name = "BookApp"
  database_name       = "free-sql-db-3528898 bookshelf/free-sql-db-3528898" 
  location            = "Canada Central"

  aad_admin_username  = "admin@MngEnvMCAP517100.onmicrosoft.com"
  aad_admin_object_id  = "d10c1b64-74e2-4205-b3af-6d24d28ca6c8"
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
