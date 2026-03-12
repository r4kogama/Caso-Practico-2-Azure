variable "subscription_id" {
  description = "ID de suscripción de Azure"
  type        = string
  sensitive   = true
}
variable "tenant_id" {
  description = "ID del tenant de Entra ID"
  type        = string
  sensitive   = true
}
variable "practica_name" {
  description = "Nombre base de la práctica"
  type        = string
  default     = "casopractico2"
}
variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg_fr"
}

variable "location" {
  description = "Región de despliegue"
  type        = string
  default     = "francecentral"
}

variable "availability_set_name" {
  description = "Nombre del Availability Set"
  type        = string
  default     = "as_fr"
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
  default     = "vpc_fr"
}

variable "asc_name" {
  description = "Nombre de la cuenta de almacenamiento"
  type        = string
  default     = "ascdevcp2"
}

variable "vnet_address_space" {
  description = "Rango CIDR de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet_vm1"
}

variable "subnet_address_prefixes" {
  description = "Rangos CIDR de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "ssh_key_name" {
  description = "Nombre de la clave SSH"
  type        = string
  default     = "vm1_fr_22.04_80_key"
}

variable "nsg_name" {
  description = "Nombre del NSG"
  type        = string
  default     = "nsg_rgfr"
}
variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
  default     = "acrdevopscasopractico2"
}

variable "nic_name" {
  description = "Nombre base de la NIC"
  type        = string
  default     = "vm1_frdev_01"
}

variable "public_ip_name" {
  description = "Nombre de la IP pública"
  type        = string
  default     = "vm1_public_ip"
}

variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
  default     = "vm1_fr_22.04_80"
}
variable "vm_computer_name" {
  description = "Hostname interno de la VM"
  type        = string
  default     = "ubuntuvm1"
}

variable "admin_username" {
  description = "Usuario administrador de la VM"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "Tamaño SKU de la VM"
  type        = string
  default     = "Standard_B2ats_v2"
}
variable "allowed_ssh_cidr" {
  description = "CIDR permitido para acceso SSH al NSG"
  type        = string
  default     = "0.0.0.0/0"
}
variable "aks_dns_prefix" {
  description = "Prefijo DNS para AKS"
  type        = string
  default     = "akscp2"
} 
variable "aks_name" {
  description = "Nombre del clúster AKS"
  type        = string
  default     = "aks_dev_fr_CP2"
}