variable name {}
variable zone {}
variable network {}
variable subnetwork {}
variable ipv4_cidr {}
variable initial_node_count {}
variable node_version {}
variable username {}
variable password {}
variable machine_type {}
variable image_type {}
variable disk_size_gb {}
variable service_account {}

resource "google_container_cluster" "cluster" {
  name               = "${var.name}"
  zone               = "${var.zone}"
  initial_node_count = "${var.initial_node_count}"

  network           = "${var.network}"
  subnetwork        = "${var.subnetwork}"
  cluster_ipv4_cidr = "${var.ipv4_cidr}"

  node_version = "${var.node_version}"

  logging_service    = "none"
  monitoring_service = "none"
 
  #additional_zones = []

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    machine_type = "${var.machine_type}"

    image_type = "${var.image_type}"

    disk_size_gb = "${var.disk_size_gb}"

    service_account = "${var.service_account}"

    local_ssd_count = 0

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/datastore",
      "https://www.googleapis.com/auth/bigquery",
    ]
  }
}

output "instance_group_urls" {
  value = ["${google_container_cluster.cluster.instance_group_urls}"]
}  
