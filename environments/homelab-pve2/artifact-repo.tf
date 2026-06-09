resource "proxmox_virtual_environment_vm" "artifact_repo_01" {
  name      = var.artifact_vm_name
  node_name = var.pve2_node_name
  vm_id     = var.artifact_vm_id

  tags = [
    "homelab",
    "artifact",
    "nexus"
  ]

  clone {
    vm_id = var.artifact_template_id
    full  = true
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.artifact_vm_cores
    type  = "host"
  }

  memory {
    dedicated = var.artifact_vm_memory
    floating  = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = var.artifact_vm_disk_size
    discard      = "on"
  }

  initialization {
    datastore_id = "local-lvm"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "andrew"
      keys     = [var.ssh_public_key]
    }
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  operating_system {
    type = "l26"
  }

  started = true
}
