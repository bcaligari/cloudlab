variable "qemu" {
  type        = string
  description = "QEMU connect URI"
  default     = "qemu:///system"
}

variable "srvcount" {
  type        = number
  description = "number of domains"
  default     = 1
}

variable "hostprefix" {
  type        = string
  description = "prefix for hostnames and volumes"
}

variable "pool" {
  type        = map(string)
  description = "pool for images"

  default = {
    "name" = ""
    "path" = "/dev/null"
  }
}

variable "osimage" {
  type        = string
  description = "the base qcow2 image for these instances"
}

variable "username" {
  type        = string
  description = "non privileged user"
  default     = "sysop"
}

variable "ssh_pub_key" {
  type        = string
  description = "ssh public key for non privileged user"
}

variable "disable_root" {
  type        = bool
  description = "whether to disable root login with provisioning passwd"
  default     = true
}

variable "memory" {
  type        = string
  description = "VM memory"
  default     = "2048"
}

variable "vcpu" {
  type        = number
  description = "VM vcpu"
  default     = 2
}

variable "bridge" {
  type        = string
  description = "KVM bridge"
  default     = "br0"
}
