resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = ["10.0.0.0/16"]

  tags = var.tags
}

# -----------------------------
# APP SUBNET
# -----------------------------

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = ["10.0.1.0/24"]
   delegation {
    name = "appservice-delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }

  
}

# -----------------------------
# PRIVATE ENDPOINT SUBNET
# -----------------------------

resource "azurerm_subnet" "private_endpoint" {
  name                 = "private-endpoint-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = ["10.0.2.0/24"]

  private_endpoint_network_policies = "Disabled"
}

# -----------------------------
# APPLICATION GATEWAY SUBNET
# -----------------------------

resource "azurerm_subnet" "gateway" {
  name                 = "gateway-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = ["10.0.3.0/24"]
}

# -----------------------------
# VM SUBNET
# -----------------------------

resource "azurerm_subnet" "vm" {
  name                 = "vm-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = ["10.0.4.0/24"]
}