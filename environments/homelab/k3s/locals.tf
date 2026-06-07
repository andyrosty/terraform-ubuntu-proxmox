locals {
  k3s_nodes = {
    k3s-control-01 = {
      role         = "control"
      cores        = 2
      memory       = 4096
      disk         = 30
      ipv4_address = "192.168.50.147/24"
      mac_address  = "bc:24:11:7a:d3:ac"
    }

    k3s-worker-01 = {
      role         = "worker"
      cores        = 4
      memory       = 8192
      disk         = 50
      ipv4_address = "192.168.50.132/24"
      mac_address  = "bc:24:11:3d:c1:83"
    }

    k3s-worker-02 = {
      role         = "worker"
      cores        = 4
      memory       = 8192
      disk         = 50
      ipv4_address = "192.168.50.110/24"
      mac_address  = "bc:24:11:7e:eb:0d"
    }
  }
}
