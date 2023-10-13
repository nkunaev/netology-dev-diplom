#####################################
############# MY VPC ################
#####################################

resource "yandex_vpc_network" "my-network" {
  name = "my-network-${terraform.workspace}"
}


 variable "subnet_cidrs" {
  type = map(list(string))
  default = {
    stage = ["192.168.10.0/24", "192.168.11.0/24", "192.168.12.0/24"]
    prod  = ["192.168.20.0/24", "192.168.21.0/24", "192.168.22.0/24"]
  }
}

locals {
  subnet_cidrs = lookup(var.subnet_cidrs, terraform.workspace, null)
}


#####################################
# SUBNET DESCRIPTION \\ PUBLIC ZONE #
#####################################

resource "yandex_vpc_subnet" "public-zone-a" {
  name           = "${terraform.workspace}-zone-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.0]
  depends_on = [ yandex_vpc_network.my-network ]
}

resource "yandex_vpc_subnet" "public-zone-b" {
  name           = "${terraform.workspace}-zone-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.1]
  depends_on = [ yandex_vpc_network.my-network ]
}

resource "yandex_vpc_subnet" "public-zone-c" {
  name           = "${terraform.workspace}-zone-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.2]
  depends_on = [ yandex_vpc_network.my-network ]
}


#####################################
############# SUBNET DATA ###########
#####################################

data "yandex_vpc_subnet" "zone-a" {
  name = "${terraform.workspace}-zone-a"
  depends_on = [ yandex_vpc_subnet.public-zone-a ]
}

data "yandex_vpc_subnet" "zone-b" {
  name = "${terraform.workspace}-zone-b"
  depends_on = [ yandex_vpc_subnet.public-zone-b ]
}

data "yandex_vpc_subnet" "zone-c" {
  name = "${terraform.workspace}-zone-c"
  depends_on = [ yandex_vpc_subnet.public-zone-c ]
}