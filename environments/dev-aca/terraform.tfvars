resource_group_name = "rg-bookshelf-aca-dev"

location = "canadacentral"

acr_name = "bookshelfacr2026"
tags = {
  Environment = "dev"
  Project     = "bookshelf"
  Platform    = "aca"
}
containerapp_env_name = "bookshelf-env-dev"