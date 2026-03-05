# Virtual Network (VPC)
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    resource    = "vpc_france"
    environment = var.practica_name
  }
}
#Availability set AZ
resource "azurerm_availability_set" "as" {
  location                    = var.location
  name                        = var.availability_set_name
  platform_fault_domain_count = 2
  resource_group_name         = azurerm_resource_group.rg.name
  tags = {
    resource    = "as_france"
    environment = var.practica_name
  }
}
# Subnet para la VM
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  address_prefixes     = var.subnet_address_prefixes
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
# IP publica
resource "azurerm_public_ip" "vm_ip" {
  allocation_method   = "Static"
  location            = var.location
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  tags = {
    resource    = "ip_public"
    environment = var.practica_name
  }
}
