# output "aca_vnet_id" {
#   value = module.network.vnet_id
# }

# output "aca_vnet_name" {
#   value = module.network.vnet_name
# }

output "shared_sql_server_fqdn" {
  value = data.terraform_remote_state.shared.outputs.sql_server_fqdn
}
