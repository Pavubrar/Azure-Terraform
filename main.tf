

module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    owner       = var.owner
  }
}
module "app_service" {
  source = "./modules/app_service"

  app_name            = var.app_name
  service_plan_name   = var.service_plan_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sku_name            = "B1"
}
