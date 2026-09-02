resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnet_address_space

  tags = var.tags
}

# -----------------------------
# APP SUBNET
# -----------------------------

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.app_subnet_address_prefixes
  default_outbound_access_enabled = false
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

  address_prefixes = var.private_endpoint_subnet_address_prefixes
default_outbound_access_enabled = false
  private_endpoint_network_policies = "Disabled"
}

# -----------------------------
# APPLICATION GATEWAY SUBNET
# -----------------------------

resource "azurerm_subnet" "gateway" {
  name                 = "gateway-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.gateway_subnet_address_prefixes
  default_outbound_access_enabled = false
}


# resource "azurerm_virtual_network" "mgmt" {
#   count = var.create_mgmt_vnet ? 1 : 0
#   name                = "vnet-mgmt"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   address_space = ["10.1.0.0/16"]
# }
# # -----------------------------
# # VM SUBNET
# # -----------------------------

# resource "azurerm_subnet" "vm" {
#   name                 = "vm-subnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.mgmt.name

#   address_prefixes = ["10.1.1.0/24"]
#   default_outbound_access_enabled = false
#   count = var.create_mgmt_vnet ? 1 : 0

# }
# # -----------------------------
# # VM NSG
# # -----------------------------

# resource "azurerm_network_security_group" "vm" {
#   count = var.create_mgmt_vnet ? 1 : 0
#   name                = "vm-nsg"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   security_rule {
#   name                       = "Allow-SSH"
#   priority                   = 100
#   direction                  = "Inbound"
#   access                     = "Allow"
#   protocol                   = "Tcp"

#   source_port_range          = "*"
#   destination_port_range     = "22"

#   source_address_prefix      = "52.229.10.150/32"

#   destination_address_prefix = "*"
# }
# }
# resource "azurerm_subnet_network_security_group_association" "vm" {
#   count = (
#     var.create_mgmt_vnet &&
#     var.create_vm_subnet_nsg_association
#   ) ? 1 : 0

#   subnet_id                 = azurerm_subnet.vm[0].id
#   network_security_group_id = azurerm_network_security_group.vm[0].id
# }

# #---VNET PEERing---#
# resource "azurerm_virtual_network_peering" "app_to_mgmt" {
#   count = var.create_mgmt_vnet ? 1 : 0
#   name                      = "app-to-mgmt"
#   resource_group_name       = var.resource_group_name

#   virtual_network_name      = azurerm_virtual_network.this.name

#   remote_virtual_network_id = azurerm_virtual_network.mgmt.id

#   allow_virtual_network_access = true
# }
# resource "azurerm_virtual_network_peering" "mgmt_to_app" {
#   count = var.create_mgmt_vnet ? 1 : 0
#   name                      = "mgmt-to-app"
#   resource_group_name       = var.resource_group_name

#   virtual_network_name      = azurerm_virtual_network.mgmt.name

#   remote_virtual_network_id = azurerm_virtual_network.this.id

#   allow_virtual_network_access = true
# }

#---VNET for ACA---#
resource "azurerm_subnet" "aca" {
  count = var.create_aca_subnet ? 1 : 0

  name                 = "aca-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.aca_subnet_address_prefixes
  default_outbound_access_enabled = false
  delegation {
    name = "aca-delegation"

    service_delegation {
      name = "Microsoft.App/environments"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

# ====Subnet for AKS==== USING IT IN MAIN FILE UNDER AKS TO KEEP THIS MNETWROK MODULE RESUABLE AND THIS D-SUBNET WOULDNOT HAVE ACCESS TO DAT.TF FROMHERE.

# resource "azurerm_subnet" "aks" {
#   name                 = "aks-subnet"
#   resource_group_name  = data.azurerm_virtual_network.aca.resource_group_name
#   virtual_network_name = data.azurerm_virtual_network.aca.name
#   address_prefixes = var.aks_subnet_address_prefixes
# }