variable "hostname" {
  description = "Hostname for the puppet server"
  type        = string
  default     = "puppet"
}

variable "ssh_public_key_pve_root" {
  description = "SSH public key of root user on Proxmox VE host"
  type        = string
}

variable "ssh_public_key_sr_mac_aljaz" {
  description = "SSH public key of my work Macbook"
  type        = string
}

variable "tailscale_key" {
  description = "Tailscale key for device authentication"
  type        = string
}
