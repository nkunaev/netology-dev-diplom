resource "yandex_iam_service_account" "k8s-editor" {
  name        = "k8s-admin"
  description = "User for edit k8s cluster"
  folder_id   = data.yandex_resourcemanager_folder.default.id
}

data "yandex_iam_service_account" "sa-terraform" {
  name = "sa-terraform"
}