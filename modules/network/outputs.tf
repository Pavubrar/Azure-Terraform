output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoint.id
}

output "gateway_subnet_id" {
  value = azurerm_subnet.gateway.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}