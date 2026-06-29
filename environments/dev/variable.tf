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
variable "app_name" {
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