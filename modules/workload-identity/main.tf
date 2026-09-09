resource "azurerm_federated_identity_credential" "this" {

  name      = var.name
  user_assigned_identity_id = var.user_assigned_identity_id

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer  = var.oidc_issuer_url
  subject = var.subject
}

resource "azurerm_role_assignment" "storage_blob_contributor" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}