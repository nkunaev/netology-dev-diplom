#####################################
########### CONTROL PLANE ###########
#####################################
variable "k8s_master_amount" {
  type = map(string)
  default = {
    stage = 3
    prod  = 3
  }
}

locals {
  control_plane_scale_size = lookup(var.k8s_master_amount, terraform.workspace, null)
}

module "k8s-master" {
  source = "./vm_group_template"

  vm_name            = "k8s-master"
  description        = "k8s-master"
  service_account_id = data.yandex_iam_service_account.sa-terraform.id
  image              = "ubuntu-2204-lts"
  network_id         = yandex_vpc_network.my-network.id
  subnets = [
    data.yandex_vpc_subnet.zone-a.id,
    data.yandex_vpc_subnet.zone-b.id,
    data.yandex_vpc_subnet.zone-c.id,
  ]
  username   = var.vm_username
  pub_key    = var.ssh_path
  scale_size = local.control_plane_scale_size
  nat        = true
  security_group = [resource.yandex_vpc_security_group.default_security_group.id]
  labels = {
    "host" = "k8s-master"
  }

  depends_on = [
    data.yandex_vpc_subnet.zone-a,
    data.yandex_vpc_subnet.zone-b,
    data.yandex_vpc_subnet.zone-c,
    resource.yandex_vpc_security_group.default_security_group
  ]
}

data "yandex_compute_instance_group" "k8s-master" {
  instance_group_id = module.k8s-master.group_id.0
  depends_on        = [module.k8s-master]
}


output "k8s_master_external_ip" {
  value = module.k8s-master.external_ip
}

output "k8s_master_internal_ip" {
  value = module.k8s-master.internal_ip
}


###############################
########### WORKERS ###########
###############################

variable "k8s_worker_amount" {
  type = map(number)
  default = {
    stage = 1
    prod  = 2
  }
}

locals {
  workers_scale_size = lookup(var.k8s_worker_amount, terraform.workspace, null)
}

module "k8s-worker" {
  source = "./vm_group_template"

  vm_name            = "k8s-worker"
  description        = "k8s-worker"
  service_account_id = data.yandex_iam_service_account.sa-terraform.id
  image              = "ubuntu-2204-lts"
  network_id         = yandex_vpc_network.my-network.id
  subnets = [
    data.yandex_vpc_subnet.zone-a.id,
    data.yandex_vpc_subnet.zone-b.id,
    data.yandex_vpc_subnet.zone-c.id,
  ]
  username   = var.vm_username
  pub_key    = var.ssh_path
  scale_size = local.workers_scale_size
  nat        = false

  depends_on = [
    data.yandex_vpc_subnet.zone-a,
    data.yandex_vpc_subnet.zone-b,
    data.yandex_vpc_subnet.zone-c
  ]

  labels = {
    "host" = "k8s-worker"
  }
}

data "yandex_compute_instance_group" "k8s-worker" {
  instance_group_id = module.k8s-worker.group_id.0
  depends_on        = [module.k8s-worker]
}

output "k8s_worker_internal_ip" {
  value = module.k8s-worker.internal_ip
}

output "k8s_worker_external_ip" {
  value = module.k8s-worker.external_ip
}