# resource "azurerm_service_plan" "plan" {
#   name                = var.service_plan_name
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   os_type  = "Linux"
#   sku_name = var.sku_name
# }

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = var.service_plan_id
  https_only          = true
  ftp_publish_basic_authentication_enabled       = false
webdeploy_publish_basic_authentication_enabled = false
  site_config {}
  lifecycle {
  ignore_changes = [
    app_settings,
    site_config,
    identity,
    sticky_settings,
    virtual_network_subnet_id
  ]
}
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count = var.app_subnet_id != null ? 1 : 0

  app_service_id = azurerm_linux_web_app.app.id
  subnet_id      = var.app_subnet_id
}
