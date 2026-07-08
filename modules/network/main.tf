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


resource "azurerm_virtual_network" "mgmt" {
  name                = "vnet-mgmt"
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = ["10.1.0.0/16"]
}
# -----------------------------
# VM SUBNET
# -----------------------------

resource "azurerm_subnet" "vm" {
  name                 = "vm-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.mgmt.name

  address_prefixes = ["10.1.1.0/24"]
}
# -----------------------------
# VM NSG
# -----------------------------

resource "azurerm_network_security_group" "vm" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
  name                       = "Allow-SSH"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"

  source_port_range          = "*"
  destination_port_range     = "22"

  source_address_prefix      = "52.229.10.150/32"

  destination_address_prefix = "*"
}
}
resource "azurerm_subnet_network_security_group_association" "vm" {

  subnet_id                 = azurerm_subnet.vm.id

  network_security_group_id = azurerm_network_security_group.vm.id
}

#---VNET PEERing---#
resource "azurerm_virtual_network_peering" "app_to_mgmt" {
  name                      = "app-to-mgmt"
  resource_group_name       = var.resource_group_name

  virtual_network_name      = azurerm_virtual_network.this.name

  remote_virtual_network_id = azurerm_virtual_network.mgmt.id

  allow_virtual_network_access = true
}
resource "azurerm_virtual_network_peering" "mgmt_to_app" {
  name                      = "mgmt-to-app"
  resource_group_name       = var.resource_group_name

  virtual_network_name      = azurerm_virtual_network.mgmt.name

  remote_virtual_network_id = azurerm_virtual_network.this.id

  allow_virtual_network_access = true
}