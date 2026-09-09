resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  oidc_issuer_enabled = true
  workload_identity_enabled = true

#   microsoft_defender {
# log_analytics_workspace_id = var.log_analytics_workspace_id
# }


  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var. vm_size
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}
resource "azurerm_role_assignment" "acr_pull" {

  scope = var.acr_id

  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
#  it is slareda dded via az cli, this is for furtuee safe if we need to reapply in any case