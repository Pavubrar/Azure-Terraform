variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}
variable "service_plan_id" {
  type = string
}

variable "service_plan_name" {
  type = string
}
variable "tenant_id" {
  type = string
}

variable "sql_admin" {
  type = string
}

variable "sql_password" {
  type      = string
  sensitive = true
}
variable "backend_app_name" {
  type = string
}

variable "frontend_app_name" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "storageAcc_name"{
  type = string
}