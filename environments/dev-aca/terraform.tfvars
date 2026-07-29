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
api_image          = "bookshelfacr2026.azurecr.io/bookshelf-api:v12" 
sql_connection_string = "Server=tcp:bookshelf.database.windows.net,1433;Initial Catalog=free-sql-db-3528898;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication=Active Directory Default;"

jwt_key = "ChangeThisDevelopmentOnlyJwtSigningKey12345!"
azure_client_id = "181664b4-5912-407d-beda-f4ace15203c1"