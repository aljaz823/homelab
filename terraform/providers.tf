terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.86.0"
    }

    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.24.0"
    }
  }
}

provider "tailscale" {
  tailnet             = var.tailscale_tailnet
  oauth_client_id     = var.tailscale_client_id
  oauth_client_secret = var.tailscale_client_secret
  scopes              = ["devices:core", "auth_keys"]
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
