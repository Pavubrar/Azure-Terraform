terraform {
  backend "azurerm" {
    resource_group_name  = "devops"
    storage_account_name = "tfstate1781994399"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}