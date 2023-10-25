module "atlantis" {
  source = "./vm_template"

  vm_name = "atlantis"
  cpu = 2
  ram = 1
  core_fraction = 20
  image = "ubuntu-2204-lts"
  nat = true

  username   = var.vm_username
  pub_key    = var.ssh_path

  subnet = data.yandex_vpc_subnet.zone-a.id
  security_group = [resource.yandex_vpc_security_group.default_security_group.id]

}

  
output "atlantis_ip" {
  value = [module.atlantis.external_ip, module.atlantis.internal_ip]
}
