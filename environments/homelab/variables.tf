variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "template_vm_id" {
  type    = number
  default = 9000
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "default_username" {
  type    = string
  default = "andrew"
}

variable "default_network_bridge" {
  type    = string
  default = "vmbr1"
}

variable "default_datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "default_ipv4_gateway" {
  description = "Default gateway for homelab VMs"
  type        = string
  default     = "192.168.50.1"
}

variable "default_dns_servers" {
  description = "Default DNS servers for homelab VMs"
  type        = list(string)
  default     = ["192.168.50.1"]
}
