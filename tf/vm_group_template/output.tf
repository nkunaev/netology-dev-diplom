output "internal_ip" {
  value = [yandex_compute_instance_group.vm_group_template.instances[*].network_interface[0].ip_address]
}

output "external_ip" {
  value = [yandex_compute_instance_group.vm_group_template.instances[*].network_interface[0].nat_ip_address]
}

output "group_id" {
  value = [yandex_compute_instance_group.vm_group_template.id]
}