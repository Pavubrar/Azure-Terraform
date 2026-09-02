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
}