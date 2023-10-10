module "gitlab" {
  source = "./vm_template"

  count    = var.k8s_master_amount["${terraform.workspace}"]
  vm_name  = "${terraform.workspace}-master-${count.index}"
  image    = "ubuntu-2204-lts"
  username = "kunaev"
  pub_key  = "~/.ssh/settings.pub"
  subnet   = yandex_vpc_subnet.public-zone-a.id
}

