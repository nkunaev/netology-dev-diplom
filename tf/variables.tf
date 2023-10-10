locals {
  ssh-key      = "kunaev:${file("~/.ssh/id_rsa.pub")}"
  subnet_cidrs = lookup(var.subnet_cidrs, terraform.workspace, null)
}


###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


variable "subnet_cidrs" {
  type = map(list(string))
  default = {
    stage = ["192.168.10.0/24", "192.168.11.0/24", "192.168.12.0/24"]
    prod  = ["192.168.20.0/24", "192.168.21.0/24", "192.168.22.0/24"]
  }
}

variable "k8s_master_amount" {
  type = map(string)
  default = {
    stage = 1
    prod  = 3
  }
}

variable "k8s_worker_amount" {
  type = map(string)
  default = {
    stage = 1
    prod  = 2
  }
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone name"
}
