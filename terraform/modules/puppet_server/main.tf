module "proxmox_virtual_environment_vm" {
  source            = "../vm_ubuntu_jammy"
  name              = var.hostname
  node_name         = "pve"
  user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id
}

resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${var.hostname}

    timezone: Europe/Ljubljana
    locale: en_US.UTF-8

    users:
      - name: ubuntu
        groups:
          - sudo
        ssh_authorized_keys:
          - ${var.ssh_public_key_pve_root}
          - ${var.ssh_public_key_sr_mac_aljaz}
        shell: /bin/bash
        sudo: "ALL=(ALL) NOPASSWD:ALL"
      - name: puppet
        shell: /usr/sbin/nologin
        sudo: false
        system: true
        home: /etc/puppetlabs

    package_upgrade: true

    packages:
      - qemu-guest-agent
      - curl

    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - curl -fsSL https://tailscale.com/install.sh | sh
      - tailscale up --authkey=${var.tailscale_key}
      - wget https://apt.puppetlabs.com/puppet7-release-jammy.deb
      - dpkg -i puppet7-release-jammy.deb
      - apt-get update
      - apt-get install -y puppetserver
      - sed -i 's/-Xms[^ ]*/-Xms512m/g; s/-Xmx[^ ]*/-Xmx512m/g' /etc/default/puppetserver
      - systemctl enable puppetserver
      - systemctl start puppetserver
    EOF

    file_name = "cloud-config.yaml"
  }
}
