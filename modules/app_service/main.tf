resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = "Linux"
  sku_name = var.sku_name
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {}
}