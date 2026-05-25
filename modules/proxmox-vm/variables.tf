variable "name" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "template_vm_id" {
  type = number
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "disk_size" {
  type = number
}

variable "datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "disk_interface" {
  type    = string
  default = "scsi0"
}

variable "network_bridge" {
  type    = string
  default = "vmbr1"
}

variable "ipv4_address" {
  type    = string
  default = "dhcp"
}

variable "username" {
  type    = string
  default = "andrew"
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}
