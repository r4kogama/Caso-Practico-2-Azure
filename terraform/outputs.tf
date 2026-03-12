output "resource_group_name" {
  description = "Nombre del Resource Group donde se despliegan los recursos"
  value       = var.resource_group_name
}

output "vm_name" {
  description = "Nombre de la máquina virtual en Azure"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "vm_id" {
  description = "Identificador único de la máquina virtual"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "network_interface_id" {
  description = "Identificador de la interfaz de red asociada a la VM"
  value       = azurerm_network_interface.nic.id
}

output "network_security_group_id" {
  description = "Identificador del Network Security Group aplicado"
  value       = azurerm_network_security_group.nsg.id
}

output "subnet_id" {
  description = "Identificador de la subred donde se conecta la VM"
  value       = azurerm_subnet.subnet.id
}

output "vm_public_ip" {
  description = "Dirección IP pública asignada a la máquina virtual"
  value       = azurerm_public_ip.vm_ip.ip_address
}

output "ssh_public_key_openssh" {
  description = "Clave pública SSH en formato OpenSSH generada por Terraform"
  value       = tls_private_key.ssh_key.public_key_openssh
}

output "ssh_private_key_path" {
  description = "Ruta local del archivo con la clave privada SSH"
  value       = local_sensitive_file.ssh_private_key.filename
}

output "acr_login_server" {
  description = "Servidor de login del Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "Usuario administrador del Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Contraseña del usuario administrador del Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "kube_config" {
  description = "Configuración de kubectl para AKS"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
} 

output "ansible_inventory_path" {
  description = "Ruta local del inventario de Ansible generado por Terraform"
  value       = local_file.ansible_inventory.filename
}