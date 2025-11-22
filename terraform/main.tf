module "puppet_server" {
  source                      = "./modules/puppet_server"
  hostname                    = "puppet"
  ssh_public_key_pve_root     = var.ssh_public_key_pve_root
  ssh_public_key_sr_mac_aljaz = var.ssh_public_key_sr_mac_aljaz
  tailscale_key               = tailscale_tailnet_key.tailscale_key.key
}

resource "tailscale_tailnet_key" "tailscale_key" {
  reusable      = true
  ephemeral     = true
  preauthorized = true
  expiry        = 3600
  tags          = ["tag:homelab", "tag:vm"]
  description   = "Key to authorize a Proxmox VM"
}
