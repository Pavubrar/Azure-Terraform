output "fqdn" {
  value = azurerm_container_app.api.latest_revision_fqdn
}