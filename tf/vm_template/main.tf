resource "yandex_compute_instance" "vm_template" {


  name        = var.vm_name
  platform_id = var.vm_maintenance_class
  hostname    = var.vm_name
  description = var.description
  labels      = var.labels

  resources {
    cores         = var.cpu
    memory        = var.ram
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.id
      size     = var.disk_size
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id = var.subnet
    security_group_ids = var.security_group
    nat = var.nat
  }

  metadata = {
    ssh-keys = "${var.username}:${file("${var.pub_key}")}"
    userdata = file("${path.module}/cloud_config.yaml")
  }
}
