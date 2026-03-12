#ACR contenedor de imagenes
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    resource    = "acr_basic"
    environment = var.practica_name
  }
}
#Administrar una identidad asignada por el usuario
resource "azurerm_user_assigned_identity" "uai" {
  location            = azurerm_resource_group.rg.location
  name                = "acr_uai"
  resource_group_name = azurerm_resource_group.rg.name
}