resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = data.azurerm_virtual_network.aca.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.aca.name

  address_prefixes = var.aks_subnet_address_prefixes
}


module "aks" {

  source = "../../modules/aks"

  cluster_name = "aks-bookshelf-dev"

  location = var.location

  resource_group_name = var.resource_group_name
  dns_prefix          = "bookshelf"
  aks_subnet_id       = azurerm_subnet.aks.id
  acr_id = data.azurerm_container_registry.shared.id
}

data "azurerm_storage_account" "storage" {
name = "csharpdq43cm"
resource_group_name = "devops"
}
module "bookshelf_workload_identity" {

  source = "../../modules/workload-identity"

  name = "bookshelf-api-federation"

  user_assigned_identity_id = data.azurerm_user_assigned_identity.shared.id

  oidc_issuer_url = module.aks.oidc_issuer_url

  subject = "system:serviceaccount:bookshelf:bookshelf-api-sa"
  storage_account_id = data.azurerm_storage_account.storage.id
principal_id       = data.azurerm_user_assigned_identity.shared.principal_id
}