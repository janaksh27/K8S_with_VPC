# Create VPC
resource "google_compute_network" "my_vpc" {
  name = "my-vpc"
}

# Create Subnet in VPC
resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-"
  ip_cidr_range = "10.0.1.0/24"  # Adjust the CIDR range as needed
  network       = google_compute_network.my_vpc.name
  region        = "us-central1"
}

# Create GKE Cluster
resource "google_container_cluster" "my_cluster" {
  name     = "my-gke-cluster"
  location = "us-central1"
  network  = google_compute_network.my_vpc.self_link
  deletion_protection = "false"


  node_pool {
    name       = "default-pool"
    initial_node_count = 1
    node_config {
      machine_type = "n1-standard-1"
    }
  }
}
