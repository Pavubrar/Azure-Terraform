# data "terraform_remote_state" "shared" {

#   backend = "azurerm"

#   config = {
#     resource_group_name  = "DevOps"
#     storage_account_name = "tfstate1781994399"
#     container_name       = "tfstate"
#     key                  = "shared.terraform.tfstate"
#   }
# }
data "azurerm_container_registry" "shared" {
  name                = "bookshelfacr2026"
  resource_group_name = "rg-bookshelf-aca-dev"
}
data "azurerm_user_assigned_identity" "shared" {
  name                = "bookshelf-api-identity"
  resource_group_name = "rg-bookshelf-aca-dev"
}
data "azurerm_virtual_network" "aca" {
  name                = "vnet-bookshelf-dev-aca-v2"
  resource_group_name = "rg-bookshelf-aca-dev"
}