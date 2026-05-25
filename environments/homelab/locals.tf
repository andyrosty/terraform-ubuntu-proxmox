locals {
  k3s_nodes = {
    k3s-control-01 = {
      role   = "control"
      cores  = 2
      memory = 4096
      disk   = 30
    }

    k3s-worker-01 = {
      role   = "worker"
      cores  = 4
      memory = 8192
      disk   = 50
    }

    k3s-worker-02 = {
      role   = "worker"
      cores  = 4
      memory = 8192
      disk   = 50
    }
  }
}
