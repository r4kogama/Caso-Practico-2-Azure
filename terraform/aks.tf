# Administra un clúster de Kubernetes  AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_prefix
  sku_tier            = "Standard"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A4v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    resource    = "developer_aks"
    environment = var.practica_name
  }
}
# Permisos de descarga de imagenes desde el acr al aks "AcrPull"
resource "azurerm_role_assignment" "role_aks" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_container_registry.acr
  ]
}
#Administra una cuenta de almacenamiento de Azure.
resource "azurerm_storage_account" "asc" {
  name                     = var.asc_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    resource = "staging"
    environment = var.practica_name
  }
}