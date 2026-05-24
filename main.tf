resource "proxmox_virtual_environment_vm" "k3s_control" {
  name      = "k3s-control-01"
  node_name = var.proxmox_node

  clone {
    vm_id = var.template_vm_id
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 30
  }

  network_device {
    bridge = "vmbr1"
  }

  initialization {
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
}
