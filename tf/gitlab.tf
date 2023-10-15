module "gitlab" {
  source = "./vm_template"

  vm_name  = "${terraform.workspace}-gitlab"
  image    = "ubuntu-2204-lts"
  username = var.vm_username
  pub_key  = var.ssh_path
  subnet   = yandex_vpc_subnet.public-zone-a.id
  nat      = true
  security_group = [resource.yandex_vpc_security_group.default_security_group.id]
  labels = {
    host : "gitlab"
  }

  depends_on = [
    data.yandex_vpc_subnet.zone-a,
    resource.yandex_vpc_security_group.default_security_group
  ]
}

data "yandex_compute_instance" "gitlab" {
  instance_id = module.gitlab.id
  depends_on  = [module.gitlab]
}

output "gitlab_server_internal_ip" {
  value = module.gitlab.internal_ip
}

output "gitlab_server_external_ip" {
  value = module.gitlab.external_ip
}
