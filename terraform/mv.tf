# Network Interface
resource "azurerm_network_interface" "nic" {
  name                           = "nic-${var.nic_name}"
  accelerated_networking_enabled = true
  location                       = var.location
  resource_group_name            = azurerm_resource_group.rg.name
  tags = {
    resource    = "nic_net_france"
    environment = var.practica_name
  }

  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
    subnet_id                     = azurerm_subnet.subnet.id
  }
  depends_on = [
    azurerm_public_ip.vm_ip
  ]
}
# Asociar NSG a NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
# Maquina Virtual UBUNTU
resource "azurerm_linux_virtual_machine" "vm" {
  admin_username        = var.admin_username
  availability_set_id   = azurerm_availability_set.as.id
  computer_name         = var.vm_computer_name
  location              = var.location
  name                  = var.vm_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  resource_group_name   = azurerm_resource_group.rg.name
  secure_boot_enabled   = true
  size                  = var.vm_size
  vtpm_enabled          = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
  boot_diagnostics {
  }
  os_disk {
    caching              = "ReadWrite"
    name                 = "${var.vm_name}-osdisk"
    disk_size_gb         = 30
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "ubuntu-22_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
  depends_on = [tls_private_key.ssh_key]
  tags = {
    resource    = "ubuntu_server"
    environment = var.practica_name
  }
}
# Generar par de claves SSH con Terraform
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Administra una clave pública SSH.
resource "azurerm_ssh_public_key" "ssh_key" {
  name                = var.ssh_key_name
  location            = var.location
  public_key          = tls_private_key.ssh_key.public_key_openssh
  resource_group_name = azurerm_resource_group.rg.name
}
# Genera un archivo local con la clave SSH privada.
resource "local_sensitive_file" "ssh_private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${pathexpand("~/.ssh")}/${var.vm_name}_id_rsa"
  file_permission = "0600"
}
#Genera un archivo local con la clave SSH publica.
resource "local_file" "ssh_public_key" {
  content         = tls_private_key.ssh_key.public_key_openssh
  filename        = "${path.module}/${var.vm_name}_id_rsa.pub"
  file_permission = "0644"
}
# Administra una cuenta de almacenamiento de Azure.
resource "azurerm_storage_account" "asc" {
  name                     = var.asc_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    resource    = "staging"
    environment = var.practica_name
  }
}

