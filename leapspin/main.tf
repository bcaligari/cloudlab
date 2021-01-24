terraform {
  required_version = "~> 0.14"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.2"
    }
  }
}

provider "libvirt" {
  uri = var.qemu
}

resource "libvirt_pool" "mainpool" {
  name = var.pool.name
  type = "dir"
  path = var.pool.path
}

resource "libvirt_volume" "osdisk" {
  count  = var.srvcount
  name   = "${var.hostprefix}-osdisk-${count.index}"
  pool   = libvirt_pool.mainpool.name
  source = var.osimage
  format = "qcow2"
}

data "template_file" "user_data" {
  count    = var.srvcount
  template = file("${path.module}/cloud-init/user_data.yaml")
  vars = {
    hostname = "${var.hostprefix}${count.index}"
    ssh_key  = file(var.ssh_pub_key)
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/cloud-init/network_config.yaml")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count          = var.srvcount
  name           = "${var.hostprefix}-init-${count.index}.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.mainpool.name
}

resource "libvirt_domain" "kvmdomain" {
  count = var.srvcount

  name   = "${var.hostprefix}-${count.index}"
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  network_interface {
    mac    = "42:A0:A0:A0:A0:A${count.index}"
    bridge = var.bridge
  }

  disk {
    volume_id = libvirt_volume.osdisk[count.index].id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

resource "local_file" "dnsmasq_injection" {
  content = templatefile(
    "${path.module}/templates/dnsmasq.tpl",
    {
      hostprefix = var.hostprefix
      macs = {
        "meh0" = "00:00",
        "meh1" = "00:01"
      }
    }
  )
  filename = "${var.hostprefix}.conf"
}
