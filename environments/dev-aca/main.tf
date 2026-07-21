module "resource_group" {
  source = "../../modules/resource_group"

  name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}