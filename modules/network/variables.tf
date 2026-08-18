variable "vnet_name" {}

variable "resource_group_name" {}

variable "location" {}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "app_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "private_endpoint_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "gateway_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.3.0/24"]
}

variable "aca_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.4.0/23"]
}

variable "create_aca_subnet" {
  type    = bool
  default = false
}

variable "create_vm_subnet_nsg_association" {
  type    = bool
  default = false
}
variable "create_mgmt_vnet" {
  type    = bool
  default = false
}