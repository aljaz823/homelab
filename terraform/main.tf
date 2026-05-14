# module "puppet_server" {
#   source                      = "./modules/puppet_server"
#   hostname                    = "puppet"
#   ssh_public_key_pve_root     = var.ssh_public_key_pve_root
#   ssh_public_key_sr_mac_aljaz = var.ssh_public_key_sr_mac_aljaz
#   tailscale_key               = var.tailscale_key
# }

# module "puppet_agent" {
#   source            = "./modules/vm_ubuntu_jammy"
#   name              = "agent1"
#   node_name         = "pve"
#   user_data_file_id = proxmox_virtual_environment_file.agent_cloud_init_user_data.id
# }

# resource "proxmox_virtual_environment_file" "agent_cloud_init_user_data" {
#   content_type = "snippets"
#   datastore_id = "local"
#   node_name    = "pve"

#   source_raw {
#     data = <<-EOF
#     #cloud-config
#     hostname: "agent1"

#     timezone: Europe/Ljubljana
#     locale: en_US.UTF-8

#     users:
#       - name: ubuntu
#         groups:
#           - sudo
#         ssh_authorized_keys:
#           - ${var.ssh_public_key_pve_root}
#           - ${var.ssh_public_key_sr_mac_aljaz}
#         shell: /bin/bash
#         sudo: "ALL=(ALL) NOPASSWD:ALL"
#       - name: puppet
#         shell: /usr/sbin/nologin
#         sudo: false
#         system: true
#         home: /etc/puppetlabs

#     package_upgrade: true

#     packages:
#       - qemu-guest-agent
#       - curl

#     runcmd:
#       - systemctl enable qemu-guest-agent
#       - systemctl start qemu-guest-agent
#       - curl -fsSL https://tailscale.com/install.sh | sh
#       - tailscale up --authkey=${var.tailscale_key}
#       - wget https://apt.puppetlabs.com/puppet7-release-jammy.deb
#       - dpkg -i puppet7-release-jammy.deb
#       - apt-get update
#       - apt-get install -y puppet-agent
#       - systemctl enable puppet
#       - systemctl start puppet
#     EOF

#     file_name = "agent-cloud-config.yaml"
#   }
# }

# resource "null_resource" "pre_destroy_tailscale" {
#   for_each = {
#     # puppet_server = module.puppet_server.ip_address
#     puppet_server = "puppet"
#     # puppet_agent = module.puppet_agent.ip_address
#     puppet_agent = "agent1"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo tailscale logout"
#     ]

#     on_failure = continue

#     connection {
#       type        = "ssh"
#       host        = self.triggers.vm_ip
#       user        = "ubuntu"
#       private_key = file("~/.ssh/id_ed25519")
#     }

#     when = destroy
#   }

#   triggers = {
#     vm_ip = each.value
#   }

#   depends_on = [
#     module.puppet_server,
#     module.puppet_agent,
#   ]
# }
