###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token. I use TF_VAR_token=$(yc iam create-token) as alias yc_renew_token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type = string
  default = "ru-central1-a"
}


variable "vm_username" {
  type = string
  default = null
}

variable "ssh_path" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}