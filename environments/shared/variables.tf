variable "location" { type = string }
variable "network_resource_group_name" { type = string }
variable "storage_resource_group_name" { type = string }
variable "sql_resource_group_name" { type = string }
variable "vnet_name" { type = string }
variable "storage_account_name" { type = string }
variable "sql_server_name" { type = string }
variable "sql_database_name" { type = string }
variable "sql_private_endpoint_name" { type = string }
variable "storage_private_endpoint_name" { type = string }
variable "sql_aad_admin_username" { type = string }
variable "sql_aad_admin_object_id" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
