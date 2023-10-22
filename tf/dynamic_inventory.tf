resource "local_file" "k8s_cluster_inventory" {
  content = templatefile("./jinja2_templates/k8s_cluster_inventory.tmpl",
    {
      k8s_master = data.yandex_compute_instance_group.k8s-master.instances[*].network_interface[0]
      k8s_worker = data.yandex_compute_instance_group.k8s-worker.instances[*].network_interface[0]
    }
  )
  filename = "../ansible/k8s_cluster_hosts.yml"
}
