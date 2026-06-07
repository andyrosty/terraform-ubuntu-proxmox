locals {
  ai_nodes = {
    ai-lab-01 = {
      cores        = 4
      memory       = 16384
      disk         = 150
      ipv4_address = "192.168.50.160/24"
      mac_address  = "bc:24:11:50:00:60"
    }
  }
}
