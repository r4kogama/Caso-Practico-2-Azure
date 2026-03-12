resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory/inventory.tmpl", {
    mv_ip            = azurerm_public_ip.vm_ip.ip_address
    ansible_user     = var.admin_username
    private_key_path = local_sensitive_file.ssh_private_key.filename
    acr_name         = azurerm_container_registry.acr.name
    vm_name          = var.vm_name
  })

  filename        = "${path.module}/../ansible/inventory/hosts.yml"
  file_permission = "0644"

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_public_ip.vm_ip,
    local_sensitive_file.ssh_private_key,
    azurerm_container_registry.acr
  ]
}
