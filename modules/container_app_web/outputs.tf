output "id" {
  value = azurerm_container_app.web.id
}

output "fqdn" {
  value = azurerm_container_app.web.latest_revision_fqdn
}