variable "name" {
  description = "Name for the VM"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name where the VM will be created"
  type        = string
}

variable "user_data_file_id" {
  description = "Proxmox file ID for cloud-init user data"
  type        = string
}
