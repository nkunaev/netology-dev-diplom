resource "iam" "name" {
  
}

module "k8s-master" {
  source = "./vm_group_template"

}
