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

  ipv4_address = each.value.ipv4_address
  ipv4_gateway = var.default_ipv4_gateway
  dns_servers  = var.default_dns_servers
  mac_address  = each.value.mac_address

  username       = var.default_username
  ssh_public_key = var.ssh_public_key
}
