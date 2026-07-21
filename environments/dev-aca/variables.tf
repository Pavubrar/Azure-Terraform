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