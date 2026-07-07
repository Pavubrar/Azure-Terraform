variable "app_name" {
  type = string
}

variable "service_plan_name" {
  type = string
}
variable "service_plan_id" {
  type = string
}
variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "sku_name" {
  type    = string
  
}

variable "enable_vnet_integration" {
  type    = bool
  default = false
}

variable "app_subnet_id" {
  type    = string
  default = null
}