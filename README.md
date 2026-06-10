# Terraform Proxmox Homelab VMs

This repository provisions homelab VMs on Proxmox using Terraform. The `modules/proxmox-vm` module encapsulates VM cloning from an existing cloud-init template, while `environments/homelab/k3s` and `environments/homelab/ai` show how to instantiate K3s and AI-focused nodes from that module.

## Repository layout

- `modules/proxmox-vm`: Opinionated module for cloning a VM, injecting SSH keys, and applying basic CPU, memory, disk, and network settings.
- `environments/homelab/k3s`: K3s environment that defines control-plane and worker nodes in `locals.tf` and calls the module for each entry.
- `environments/homelab/ai`: AI lab environment that defines AI nodes in `locals.tf` and calls the module for each entry.
- `terraform.tfvars.example` and `environments/homelab/terraform.tfvars.example`: Sample variable files you can copy and adapt to match your lab.

## Prerequisites

- Terraform 1.3+ installed locally
- Access to a Proxmox cluster plus an API token with permission to clone the base template
- A template VM (defaults to ID `9000`) prepared with cloud-init networking and SSH
- An SSH keypair (defaults to `~/.ssh/id_ed25519.pub`). Generate one with `ssh-keygen -t ed25519 -C "andrew-homelab"`

## Configure variables

1. Change into the desired environment directory, e.g. `cd environments/homelab/k3s`.
2. Copy the homelab sample variables file into that environment and edit the values to match your Proxmox installation:

   ```bash
   cp ../terraform.tfvars.example terraform.tfvars
   ```

3. Export sensitive values so Terraform can read them without committing secrets to disk:

   ```bash
   export TF_VAR_proxmox_api_token="terraform@pve!homelab=YOUR_SECRET_TOKEN"
   export TF_VAR_proxmox_endpoint="https://your-proxmox-host:8006/api2/json"
   export TF_VAR_ssh_public_key="$(cat ~/.ssh/id_ed25519.pub)"
   ```

   These environment variables supply the `proxmox_api_token`, `proxmox_endpoint`, and `ssh_public_key` inputs referenced in each environment's `variables.tf` (for example, `environments/homelab/k3s/variables.tf`).

4. Adjust the node inventory in `environments/homelab/k3s/locals.tf` if you need a different mix of control-plane and worker nodes. Each entry lets you change CPU cores, RAM, and disk size:

   ```hcl
   locals {
     k3s_nodes = {
       k3s-control-01 = { role = "control", cores = 2, memory = 4096, disk = 30 }
       k3s-worker-01  = { role = "worker", cores = 4, memory = 8192, disk = 50 }
     }
   }
   ```

   Shared defaults such as `default_username`, `default_network_bridge`, and `default_datastore_id` live in `variables.tf` so you can override them per environment without touching the module.

## Usage

### K3s homelab environment

Run Terraform from inside the K3s environment directory:

```bash
cd environments/homelab/k3s
terraform init
terraform plan
terraform apply
```

### AI lab environment

This repository also includes an AI-focused lab under `environments/homelab/ai`. To plan and apply that environment using a named plan file:

```bash
cd environments/homelab/ai
terraform init
terraform plan -out ai-lab-01.tfplan
terraform apply ai-lab-01.tfplan
```

### What the module does

The module clones the specified `template_vm_id` on the node named by `var.proxmox_node`, attaches it to `var.default_network_bridge`, sizes the VM based on the relevant `locals.k3s_nodes` (or AI node) entry, and injects the exported SSH public key for the configured username. Cloud-init requests DHCP by default but you can supply a static address via the module's `ipv4_address` variable if needed.

## Outputs

Applying the configuration emits a `k3s_nodes` map that includes the VM ID, name, and discovered IPv4 addresses for each node. Use it to feed Ansible inventory files or to verify which IPs were assigned.

## Cleanup

Destroy the lab from the same directory when you're finished:

```bash
terraform destroy
```

This tears down every VM created through the `k3s_nodes` module instances.
