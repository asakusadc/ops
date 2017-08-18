module "network" {
  source = "./modules/network"

  name        = "${terraform.workspace}"
  subnetworks = "${var.subnetworks}"
}    
