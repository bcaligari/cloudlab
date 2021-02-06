# SLES 15 SP2 image for RKE hosts

source "qemu" "sles15sp2rke" {
  iso_url           = "/srv/vastita/media/SLE-15-SP2-Full-x86_64-GM-Media1.iso"
  iso_checksum      = "md5:c89ca2557cb3544b114f6a6da5d5f5d0"
  output_directory  = "artifacts"
  shutdown_command  = "sleep 300; systemctl poweroff"
  disk_size         = "32G"
  memory            = "2048"
  format            = "qcow2"
  accelerator       = "kvm"
  http_directory    = "./www"
  ssh_username      = "root"
  ssh_password      = "S4vill3"
  ssh_timeout       = "20m"
  vm_name           = "sles15sp2rke"
  net_bridge        = "br0"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = [
                        "<down>",
                        "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinst.xml",
                        "<enter>",
                        "<wait>"
                      ]
}

build {
  sources = ["source.qemu.sles15sp2rke"]

  provisioner "ansible" {
    playbook_file = "./provision_image.yml"    
  }
}
