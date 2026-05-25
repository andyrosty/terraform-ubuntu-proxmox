module "k3s_nodes" {
  source = "../../modules/proxmox-vm"

  for_each = local.k3s_nodes

  name           = each.key
  proxmox_node   = var.proxmox_node
  template_vm_id = var.template_vm_id

  cores     = each.value.cores
  memory    = each.value.memory
  disk_size = each.value.disk

  datastore_id   = var.default_datastore_id
  network_bridge = var.default_network_bridge

  username       = var.default_username
  ssh_public_key = var.ssh_public_key
}
