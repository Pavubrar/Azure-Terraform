resource_group_name = "rg-bookshelf-aca-dev"

location = "canadacentral"

acr_name = "bookshelfacr2026"
tags = {
  Environment = "dev"
  Project     = "bookshelf"
  Platform    = "aca"
}
containerapp_env_name = "bookshelf-env-dev-v2"

api_container_name    = "bookshelf-api-app-v2"
api_image             = "bookshelfacr2026.azurecr.io/bookshelf-api:latest"
sql_connection_string = "Server=tcp:bookshelf.database.windows.net,1433;Initial Catalog=free-sql-db-3528898;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication=Active Directory Managed Identity;User Id=1e115940-d5b0-4187-82fd-1116517fdcee removing for testing purpose;"


jwt_key            = "ChangeThisDevelopmentOnlyJwtSigningKey12345!"
azure_client_id    = "1e115940-d5b0-4187-82fd-1116517fdcee"
web_image          = "bookshelfacr2026.azurecr.io/bookshelf-web:latest"
web_container_name = "bookshelf-web-app-v2"
vnet_name          = "vnet-bookshelf-dev-aca-v2"
vnet_address_space = ["10.2.0.0/16"]

aca_subnet_address_prefixes              = ["10.2.1.0/24"]
app_subnet_address_prefixes              = ["10.2.2.0/24"]
private_endpoint_subnet_address_prefixes = ["10.2.3.0/24"]
gateway_subnet_address_prefixes          = ["10.2.4.0/24"]
