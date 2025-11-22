resource "proxmox_virtual_environment_vm" "vm_ubuntu_jammy" {
  name      = var.name
  node_name = var.node_name

  template = false

  agent {
    enabled = true
  }

  scsi_hardware = "virtio-scsi-pci"
  boot_order    = ["scsi0"]

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    import_from  = proxmox_virtual_environment_download_file.latest_ubuntu_22_jammy_qcow2_img.id
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = var.user_data_file_id
  }
}

resource "proxmox_virtual_environment_download_file" "latest_ubuntu_22_jammy_qcow2_img" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  file_name    = "jammy-server-cloudimg-amd64.qcow2"
}
