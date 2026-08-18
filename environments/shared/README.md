# Shared infrastructure

This state owns infrastructure that is used by application environments:

- shared VNet and the private-endpoint subnet
- Azure SQL server and database
- Storage account
- private endpoints and their private DNS zones for SQL and Blob Storage

`dev-aca` consumes this state through `terraform_remote_state`. It creates both
directions of VNet peering and links its ACA VNet to the two private DNS zones.
As a result, the normal SQL and Blob host names resolve to the private endpoint
IP addresses from the ACA VNet.

## First deployment

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and replace every
   placeholder with valid, unused Azure names and your Entra admin values.
2. Run `terraform init` and `terraform apply` in this directory.
3. Run `terraform init` and `terraform apply` in `../dev-aca`.

Before the `dev-aca` apply, update its `sql_connection_string` so its server
and database match the `sql_server_fqdn` and `sql_database_name` outputs from
this state. Keep the regular `*.database.windows.net` hostname in the
connection string: the linked private DNS zone translates it to the private
endpoint IP address.

The identity used for `dev-aca` needs permissions to create VNet peerings and
Private DNS VNet links in the shared resource group, in addition to its normal
permissions in the ACA resource group.

## Existing resources

Do not apply this configuration with names of resources that Terraform already
manages in another state. Move/import them into `shared` first, then remove the
old resource addresses from the old state. This prevents Terraform from trying
to create duplicates or delete live infrastructure.
