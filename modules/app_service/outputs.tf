output "app_service_name" {
  value = azurerm_linux_web_app.app.name
}

output "app_service_default_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}