# Terraform Proxmox K3s VM

This repository contains a minimal Terraform configuration for cloning a K3s control-plane virtual machine on a Proxmox Virtual Environment (PVE) cluster. It uses the open-source [`bpg/proxmox`](https://registry.terraform.io/providers/bpg/proxmox/latest) provider to create a VM from an existing template and inject an SSH public key for remote access.

## Prerequisites

- Terraform 1.3+ installed locally
- Access to a Proxmox cluster and an API token that can clone the base template
- A template VM (defaults to ID `9000`) prepared with cloud-init
- An SSH keypair (defaults to `~/.ssh/id_ed25519.pub` for the public key). Generate one with:

  ```bash
  ssh-keygen -t ed25519 -C "andrew-homelab"
  ```

## Configuration

1. Copy the sample variables file and adjust values to match your environment:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # edit terraform.tfvars to set endpoint, node name, template ID, etc.
   ```

2. Export sensitive values so Terraform can read them without storing secrets on disk:

   ```bash
   export TF_VAR_proxmox_api_token="terraform@pve!homelab=YOUR_SECRET_TOKEN"
   export TF_VAR_ssh_public_key="$(cat ~/.ssh/id_ed25519.pub)"
   ```

   These exports populate the `proxmox_api_token` and `ssh_public_key` variables defined in `variables.tf`.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

The configuration provisions a VM named `k3s-control-01` on the node specified by `var.proxmox_node`, clones the template identified by `var.template_vm_id`, attaches it to `vmbr1`, and requests an IP address via DHCP. Cloud-init injects the exported SSH public key for the `andrew` user.

## Variables

- `proxmox_endpoint` (string): HTTPS endpoint of the Proxmox API.
- `proxmox_api_token` (sensitive string): API token exported as `TF_VAR_proxmox_api_token`.
- `proxmox_insecure` (bool): Skip TLS verification; defaults to `true`.
- `proxmox_node` (string): Proxmox node to target; defaults to `proxmox`.
- `template_vm_id` (number): Template VM ID to clone; defaults to `9000`.
- `ssh_public_key` (sensitive string): Injected public key, supplied via `TF_VAR_ssh_public_key`.

Adjust these values in `terraform.tfvars` or via environment variables as needed.

## Cleanup

```bash
terraform destroy
```

This removes the VM that was provisioned by the configuration.