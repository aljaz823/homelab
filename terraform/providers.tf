terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.86.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true

  ssh {
    agent       = false
    private_key = file("~/.ssh/id_ed25519")
    username    = "root"

    node {
      name    = "pve"
      address = var.proxmox_pve_node_ip
    }
  }
}
