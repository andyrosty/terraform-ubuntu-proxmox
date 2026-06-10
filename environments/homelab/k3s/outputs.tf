output "k3s_nodes" {
  value = {
    for name, node in module.k3s_nodes : name => {
      vm_id          = node.vm_id
      name           = node.name
      ipv4_addresses = node.ipv4_addresses
    }
  }
}
