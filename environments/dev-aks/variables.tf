variable "location" {}
variable "environment" {}
variable "aks_subnet_address_prefixes" {
  type = list(string)
}



variable "resource_group_name" {
  type = string
}