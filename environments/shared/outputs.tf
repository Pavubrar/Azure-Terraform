output "resource_group_name" {
  value = var.network_resource_group_name
}

output "location" {
  value = var.location
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "dev_vnet_id" {
  value = module.network.vnet_id
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "dev_vnet_name" {
  value = module.network.vnet_name
}

output "dev_vnet_resource_group_name" {
  value = var.network_resource_group_name
}

output "app_subnet_id" {
  value = module.network.app_subnet_id
}

output "private_endpoint_subnet_id" {
  value = module.network.private_endpoint_subnet_id
}

output "gateway_subnet_id" {
  value = module.network.gateway_subnet_id
}

output "vm_subnet_id" {
  value = module.network.vm_subnet_id
}

output "mgmt_vnet_id" {
  value = module.network.mgmt_vnet_id
}

output "sql_server_id" {
  value = module.database.sql_server_id
}

output "sql_server_name" {
  value = module.database.server_name
}

output "sql_server_fqdn" {
  value = module.database.server_fqdn
}

output "sql_database_name" {
  value = module.database.database_name
}

output "sql_private_endpoint_ip" {
  value = module.sql_private_endpoint.private_endpoint_ip
}

output "storage_account_id" {
  value = module.storage.storage_account_id
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "sql_private_dns_zone_name" {
  value = module.sql_private_endpoint.private_dns_zone_name
}

output "storage_blob_private_dns_zone_name" {
  value = module.storage_private_endpoint.private_dns_zone_name
}
