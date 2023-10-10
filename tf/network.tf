#####################################
############# MY VPC ################
#####################################

resource "yandex_vpc_network" "my-network" {
  name = "my-network-${terraform.workspace}"
}

#####################################
# SUBNET DESCRIPTION \\ PUBLIC ZONE #
#####################################

resource "yandex_vpc_subnet" "public-zone-a" {
  name           = "${terraform.workspace}-zone-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.0]
}

resource "yandex_vpc_subnet" "public-zone-b" {
  name           = "${terraform.workspace}-zone-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.1]
}

resource "yandex_vpc_subnet" "public-zone-c" {
  name           = "${terraform.workspace}-zone-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = [local.subnet_cidrs.2]
}

