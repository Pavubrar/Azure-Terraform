variable "name" {}

variable "location" {}

variable "resource_group_name" {}

variable "subnet_id" {}

variable "private_connection_resource_id" {}

variable "subresource_names" {
  type = list(string)
}

variable "private_dns_zone_name" {}

variable "vnet_id" {}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "mgmt_vnet_id" {
  type = string
}