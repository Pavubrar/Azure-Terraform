location                    = "Canada Central"
network_resource_group_name = "DevOps"
storage_resource_group_name = "devops"
sql_resource_group_name     = "BookApp"

vnet_name                    = "dev-vnet"
storage_account_name          = "csharpdq43cm"
sql_server_name               = "bookshelf"
sql_database_name             = "free-sql-db-3528898"
sql_private_endpoint_name     = "sql-pep"
storage_private_endpoint_name = "storage"

sql_aad_admin_username  = "admin@MngEnvMCAP517100.onmicrosoft.com"
sql_aad_admin_object_id = "d10c1b64-74e2-4205-b3af-6d24d28ca6c8"

tags = {
  environment = "dev"
  managed_by  = "terraform"
}
