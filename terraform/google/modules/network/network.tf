variable "name" {}

variable "subnetworks" {
  type = "list"
}

resource "google_compute_network" "network" {
  name = "${var.name}"
}

resource "google_compute_subnetwork" "subnetworks" {
  count   = "${length(var.subnetworks)}"
  name    = "${var.name}-${lookup(var.subnetworks[count.index], "region")}"
  region  = "${lookup(var.subnetworks[count.index], "region")}"
  network = "${google_compute_network.network.self_link}"

  ip_cidr_range = "${lookup(var.subnetworks[count.index], "cidr")}"
}

output "name" {
  value = "${google_compute_network.network.name}"
}

output "subnet_cidrs" {
  value = "${zipmap(google_compute_subnetwork.subnetworks.*.region, google_compute_subnetwork.subnetworks.*.ip_cidr_range)}"
}

output "subnet_names" {
  value = "${zipmap(google_compute_subnetwork.subnetworks.*.region, google_compute_subnetwork.subnetworks.*.name)}"
}     
