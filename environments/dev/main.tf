
data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = "devops"
    storage_account_name = "tfstate1781994399"
    container_name       = "tfstate"
    key                  = "shared.terraform.tfstate"
    use_azuread_auth     = true
  }
}

# module "resource_group" {
#   source = "../../modules/resource_group"

#   name     = var.resource_group_name
#   location = var.location

#   tags = {
#     environment = var.environment
#     owner       = var.owner
#   }
# }

module "app_service" {
  source = "../../modules/app_service"

  app_name                = var.backend_app_name
  service_plan_name       = var.service_plan_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.sku_name
  service_plan_id         = var.service_plan_id
  enable_vnet_integration = true
  app_subnet_id           = data.terraform_remote_state.shared.outputs.app_subnet_id

}

module "frontend" {
  source = "../../modules/app_service"

  app_name                = var.frontend_app_name
  service_plan_name       = var.service_plan_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.sku_name
  service_plan_id         = var.service_plan_id
  enable_vnet_integration = false

}
# module "key_vault" {
#   source = "../../modules/key_vault"

#   name                = "kv-prod"
#   resource_group_name = "rg-prod"
#   location            = "Canada Central"
#   tenant_id           = var.tenant_id
# }

module "vm" {

  source = "../../modules/vm"

  vm_name = "mgmt-vm"

  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id = data.terraform_remote_state.shared.outputs.vm_subnet_id

  admin_username = "azureuser"

  public_key = file(var.ssh_public_key_path)
  #--later will add this ssh into seciriyt file in devops

}

# =========== simple boiler plate kind of setup to create rg and web app i azure app services"
# module "resource_group" {
#   source = "./modules/resource_group"

#   name     = var.resource_group_name
#   location = var.location

#   tags = {
#     environment = var.environment
#     owner       = var.owner
#   }
# }
# module "app_service" {
#   source = "./modules/app_service"

#   app_name            = var.app_name
#   service_plan_name   = var.service_plan_name
#   location            = var.location
#   resource_group_name = module.resource_group.resource_group_name
#   sku_name            = "B1"
# }
