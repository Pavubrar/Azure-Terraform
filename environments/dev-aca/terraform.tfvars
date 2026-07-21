resource_group_name = "rg-bookshelf-aca-dev"

location = "canadacentral"

acr_name = "bookshelfacr2026"
tags = {
  Environment = "dev"
  Project     = "bookshelf"
  Platform    = "aca"
}
containerapp_env_name = "bookshelf-env-dev"

api_container_name = "bookshelf-api-app"
api_image          = "bookshelfacr2026.azurecr.io/bookshelf-api:v1"