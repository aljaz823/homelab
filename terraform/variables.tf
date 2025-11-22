variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://100.108.176.128:8006"
}

variable "proxmox_pve_node_ip" {
  description = "Proxmox PVE node IP address"
  type        = string
  default     = "100.108.176.128"
}

variable "proxmox_api_token" {
  description = "Proxmox API token for Terraform"
  type        = string
}

variable "tailscale_tailnet" {
  description = "Tailscale tailnet name"
  type        = string
}

variable "tailscale_client_id" {
  description = "Tailscale OAuth client ID"
  type        = string
}

variable "tailscale_client_secret" {
  description = "Tailscale OAuth client secret"
  type        = string
}

variable "ssh_public_key_pve_root" {
  description = "SSH public key of root user on Proxmox VE host"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcegx+WxJxyYOaut+MtUL3wZIMrJg5Dn5urBvu6hK8zaGx9ajt/aoT8+nfpLV2P0ZAODOmKXe90sbvAKYIrzuaRXYNNd5Om6PtjNB/KmXRpComobBDIPhnmfjdgkfgJQNwIpr7Tzl920yoMIANxaPdkr66zh2/3VcxWoGcdgXsVxu8gsPwJJdBZEmw6gH0yZl+xgOzm8LuBdMLrlmk99OQ4p0ZkpIZQObh5UT9eDX9oUfVXFS4Jcsdv4zMu4Lv02NdbepHpf0QbceZGIrZglq5EYRL2yyonbKlxlvX7Ti9yBxZjiceS6yGg9pkml6IMW9f4S4GIAKv1FjL56Wpn/AHmxhGzUhV5wVqE+/TU0JeuAep4Rk9vxM7ga7f2bhU2DyfoG39rdes2wmf8zfVGEeVxuhlHPEGLdnRNwIKGDR8rRTEopBvYOpckUW5IQs3GbSyPV1iILBR7R1LYE4L80rPxLOD/2swPo4pYwfTUNawGvy+x/0O4gn6HvnRymLUsnHI+eesodn8xnN1zRk3fzYggYAjPGpcG8XzfQmjWmgzg7hy97K3fSLhaA6kQ75w8y4VWtnDnU+5kdsKKvi/9M6KqMw4E3qNIETXO9fRWLmKUfnT4dUybmBk9DIBVv2Pm8XQ1SiQnduc/73ZN3pFTPI0MSFFZnH/zb3BK/oaa2ZzOw== root@pve"
}

variable "ssh_public_key_sr_mac_aljaz" {
  description = "SSH public key of my work Macbook"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsuR5Q6mDxLrXF3qIIUyy4YUrTHAou9xqQnQoYMaXlN a.pungercar@LJU-M-JQLK6YHT6T"
}

variable "puppet_forge_api_key" {
  description = "Puppet Forge API key, expiry date: 21 Nov 2026"
  type        = string
}
