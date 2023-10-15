resource "yandex_compute_instance_group" "vm_group_template" {

  name               = var.vm_name
  folder_id          = var.folder_id
  service_account_id = var.service_account_id
  labels             = var.labels

  instance_template {

    labels      = var.labels
    description = var.vm_name

    resources {
      cores         = var.cpu
      memory        = var.ram
      core_fraction = var.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.os.id
        size     = var.disk_size
        type     = "network-ssd"
      }
    }

    network_interface {
      network_id = var.network_id
      security_group_ids = var.security_group
      subnet_ids = var.subnets
      nat        = var.nat
    }
    network_settings {
      type = "STANDARD"
    }
    metadata = {
      ssh-keys = "${var.username}:${file("${var.pub_key}")}"
    }

    scheduling_policy {
      preemptible = var.preemptible
    }
  }

  allocation_policy {
    zones = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
  }

  scale_policy {
    fixed_scale {
      size = var.scale_size
    }
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}