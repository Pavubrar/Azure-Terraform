module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}
module "container_app_environment" {
  source = "../../modules/container_app_environment"

  name                = var.containerapp_env_name
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}
module "managed_identity" {
  source              = "../../modules/managed_identity"
  name                = "bookshelf-api-identity"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = module.managed_identity.principal_id
  role_definition_name = "AcrPull"
  scope                = module.acr.acr_id
}