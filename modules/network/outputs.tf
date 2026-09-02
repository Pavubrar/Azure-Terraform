output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
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

# output "vm_subnet_id" {
#   value = azurerm_subnet.vm.id
# }
# output "mgmt_vnet_id" {
#   value = azurerm_virtual_network.mgmt.id
# }
 output "aca_subnet_id" {
  value = var.create_aca_subnet ? azurerm_subnet.aca[0].id : null
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}
