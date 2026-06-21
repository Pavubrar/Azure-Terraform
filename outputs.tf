output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_location" {
  value = module.resource_group.resource_group_location
}
output "app_url" {
  value = module.app_service.app_service_default_hostname
}

output "app_name" {
  value = module.app_service.app_service_name
}