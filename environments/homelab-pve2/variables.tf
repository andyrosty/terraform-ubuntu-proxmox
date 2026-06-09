variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API endpoint."
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "Proxmox API token. Pass this through an environment variable, not tfvars."
}

variable "proxmox_insecure" {
  type        = bool
  default     = true
  description = "Skip TLS verification for Proxmox self-signed certificates."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected into the VM with cloud-init."
}

variable "pve2_node_name" {
  type        = string
  default     = "pve2"
  description = "Target Proxmox node for pve2 workloads."
}

variable "artifact_template_id" {
  type        = number
  default     = 9100
  description = "Ubuntu cloud-init template VM ID on pve2."
}

variable "artifact_vm_id" {
  type        = number
  default     = 201
  description = "VM ID for artifact repository VM."
}

variable "artifact_vm_name" {
  type        = string
  default     = "artifact-repo-01"
  description = "Name of the artifact repository VM."
}

variable "artifact_vm_memory" {
  type        = number
  default     = 4096
  description = "Dedicated memory for artifact repository VM in MB."
}

variable "artifact_vm_cores" {
  type        = number
  default     = 2
  description = "CPU cores for artifact repository VM."
}

variable "artifact_vm_disk_size" {
  type        = number
  default     = 100
  description = "Disk size for artifact repository VM in GB."
}
