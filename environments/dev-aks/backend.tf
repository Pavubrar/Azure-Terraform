terraform {
  backend "azurerm" {
    resource_group_name  = "DevOps"
    storage_account_name = "tfstate1781994399"
    container_name       = "tfstate"
    key                  = "dev-aks.terraform.tfstate"
    use_azuread_auth     = true
  }
}