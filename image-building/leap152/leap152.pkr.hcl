# Leap 15.2 image

source "qemu" "leap152" {
  iso_url           = "/srv/vastita/media/openSUSE-Leap-15.2-DVD-x86_64.iso"
  iso_checksum      = "md5:eba94158bc2ca5ec1265aeb12f0606a1"
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
  vm_name           = "leap152"
  net_bridge        = "br0"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = ["<down>autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinst.xml<enter><wait>"]
}

build {
  sources = ["source.qemu.leap152"]

  provisioner "ansible" {
    playbook_file = "./provision_image.yml"    
  }
}
