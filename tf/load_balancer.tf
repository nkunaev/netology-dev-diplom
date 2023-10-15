resource "yandex_lb_target_group" "control-plane" {
  name      = "k8s-control-plane"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = [for nodes in data.yandex_compute_instance_group.k8s-master.instances : {
      address = nodes.network_interface.0.ip_address
      subnet_id = nodes.network_interface.0.subnet_id
    }]

    content {
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }

  depends_on = [ data.yandex_compute_instance_group.k8s-master ]
}

resource "yandex_lb_network_load_balancer" "k8s-lb" {
  name = "network-load-balancer"
  depends_on = [ yandex_lb_target_group.control-plane ]

  listener {
    name = "listener"
    port = 6443
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${ yandex_lb_target_group.control-plane.id }"

    healthcheck {
      name = "http"
      http_options {
        port = 6443
        path = "/"
      }
    }
  }
}

data "yandex_lb_network_load_balancer" "k8s-lb" {
  network_load_balancer_id = yandex_lb_network_load_balancer.k8s-lb.id
  depends_on = [ yandex_lb_network_load_balancer.k8s-lb ]
}

output "lb_external_ip" {
  value = data.yandex_lb_network_load_balancer.k8s-lb.listener
}