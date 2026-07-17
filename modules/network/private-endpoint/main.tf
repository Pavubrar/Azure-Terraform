# ---------------------------------
# PRIVATE DNS ZONE
# ---------------------------------

resource "azurerm_private_dns_zone" "this" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# ---------------------------------
# DNS LINK TO VNET for app to private endpoints
# ---------------------------------

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name

  virtual_network_id = var.vnet_id

  registration_enabled = false

  tags = var.tags
}
resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_mgmt" {
  name                  = "sql-pep-dns-link"
  resource_group_name   = "DevOps"
  private_dns_zone_name = "privatelink.database.windows.net"
  virtual_network_id    = var.mgmt_vnet_id
}

# ---------------------------------
# PRIVATE ENDPOINT
# ---------------------------------

resource "azurerm_private_endpoint" "this" {
  name                = "${var.name}-pep"
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.private_connection_resource_id

    is_manual_connection = false

    subresource_names = var.subresource_names
  }

  private_dns_zone_group {
    name                 = "${var.name}-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
  }
  tags = var.tags
}