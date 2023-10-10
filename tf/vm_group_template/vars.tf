variable "vm_maintenance_class" {
  type    = string
  default = "standard-v1"
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "folder_id" {
  type    = string
  default = ""
}

variable "network_id" {
  type    = string
  default = ""
}

variable "service_account_id" {
  type    = string
  default = ""
}

variable "description" {
  type    = string
  default = ""
}

variable "security_group" {
  type    = string
  default = ""
}

variable "cpu" {
  type    = number
  default = 2
}

variable "ram" {
  type    = number
  default = 1
}

variable "core_fraction" {
  type    = number
  default = 5
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "image" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "username" {
  type    = string
  default = ""
}

variable "pub_key" {
  type    = string
  default = ""
}

variable "scale_size" {
  type    = number
  default = 1
}

variable "subnets" {
  default = null
}

variable "nat" {
  type    = bool
  default = false
}

data "yandex_compute_image" "os" {
  family = var.image
}