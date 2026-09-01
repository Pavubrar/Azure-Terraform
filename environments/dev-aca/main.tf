data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = "devops"
    storage_account_name = "tfstate1781994399"
    container_name       = "tfstate"
    key                  = "shared.terraform.tfstate"
    use_azuread_auth     = true
  }
}

module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
# module "network" {
#   source = "../../modules/network"

#   location            = var.location
#   resource_group_name = module.resource_group.resource_group_name
#   vnet_name           = var.vnet_name
#   vnet_address_space                     = var.vnet_address_space
#   aca_subnet_address_prefixes            = var.aca_subnet_address_prefixes
#   app_subnet_address_prefixes            = var.app_subnet_address_prefixes
#   private_endpoint_subnet_address_prefixes = var.private_endpoint_subnet_address_prefixes
#   gateway_subnet_address_prefixes        = var.gateway_subnet_address_prefixes
#   create_aca_subnet                      = true
#   create_vm_subnet_nsg_association = true
# }

# This state owns both peering directions, so shared does not need to read this
# state and the shared <-> dev-aca dependency remains one-way.
# module "shared_vnet_peering" {
#   source = "../../modules/vnet_peering"

#   local_to_remote_name       = "aca-to-shared"
#   remote_to_local_name       = "shared-to-aca"
#   local_resource_group_name  = module.resource_group.resource_group_name
#   local_vnet_name            = module.network.vnet_name
#   local_vnet_id              = module.network.vnet_id
#   remote_resource_group_name = data.terraform_remote_state.shared.outputs.resource_group_name
#   remote_vnet_name           = data.terraform_remote_state.shared.outputs.vnet_name
#   remote_vnet_id             = data.terraform_remote_state.shared.outputs.vnet_id
# }

# A Private DNS zone must be linked to every VNet that resolves its private
# endpoint addresses. Peering provides the network path to those addresses.
# resource "azurerm_private_dns_zone_virtual_network_link" "shared_sql" {
#   name                  = module.network.vnet_name
#   resource_group_name   = data.terraform_remote_state.shared.outputs.resource_group_name
#   private_dns_zone_name = data.terraform_remote_state.shared.outputs.sql_private_dns_zone_name
#   virtual_network_id    = module.network.vnet_id
#   registration_enabled  = false
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "shared_storage_blob" {
#   name                  = "aca-storage-blob-private-dns"
#   resource_group_name   = data.terraform_remote_state.shared.outputs.resource_group_name
#   private_dns_zone_name = data.terraform_remote_state.shared.outputs.storage_blob_private_dns_zone_name
#   virtual_network_id    = module.network.vnet_id
#   registration_enabled  = false
# }

module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}
# module "container_app_environment" {
#   source = "../../modules/container_app_environment"

#   name                     = var.containerapp_env_name
#   location                 = module.resource_group.resource_group_location
#   resource_group_name      = module.resource_group.resource_group_name
#   infrastructure_subnet_id = module.network.aca_subnet_id

# }
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
# module "container_app_api" {
#   source = "../../modules/container_app_api"

#   name                         = var.api_container_name
#   resource_group_name          = module.resource_group.resource_group_name
#   container_app_environment_id = module.container_app_environment.id

#   identity_id = module.managed_identity.id

#   registry_server = module.acr.login_server

#   image                 = var.api_image
#   sql_connection_string = var.sql_connection_string
#   jwt_key               = var.jwt_key
#   azure_client_id       = var.azure_client_id
#   storage_account_name  = data.terraform_remote_state.shared.outputs.storage_account_name

#   depends_on = [azurerm_role_assignment.acr_pull]
# }
# module "container_app_web" {
#   source                       = "../../modules/container_app_web"
#   name                         = var.web_container_name
#   resource_group_name          = module.resource_group.resource_group_name
#   container_app_environment_id = module.container_app_environment.id

#   registry_server = module.acr.login_server
#   identity_id     = module.managed_identity.id

#   image = var.web_image

#   depends_on = [azurerm_role_assignment.acr_pull]
# }
# # ====Migration aca_job====

# module "migration_job" {

#   source = "../../modules/container_app_job_migration"

#   name = "bookshelf-db-migration"

#   resource_group_name = module.resource_group.resource_group_name
#   location            = module.resource_group.resource_group_location

#   container_app_environment_id = module.container_app_environment.id

#   identity_id = module.managed_identity.id

#   registry_server = module.acr.login_server

#   image = var.api_image

#   sql_connection_string = var.sql_connection_string

#   azure_client_id = var.azure_client_id

#   depends_on = [azurerm_role_assignment.acr_pull]
# }
