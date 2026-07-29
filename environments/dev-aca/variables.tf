variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "tags" {
  type = map(string)

  default = {
    Environment = "dev"
    Project     = "bookshelf"
    Platform    = "containerapps"
  }
}
variable "containerapp_env_name" {
  type = string
}
variable "api_container_name" {
  type = string
}

variable "api_image" {
  type = string
}
variable "sql_connection_string" {
  sensitive = true
}

variable "jwt_key" {
  sensitive = true
}
variable "azure_client_id" {
  type = string
}
variable "web_image" {
  type = string
}
variable "web_container_name" {
  type = string
}