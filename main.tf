terraform {
  backend "gcs" {
    bucket  = "rajan-tf-state-99898989999" # <-- Use the exact name you just created
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment_prefix}-vpc" 
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment_prefix}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}

# 1. The GKE Cluster (Control Plane)
resource "google_container_cluster" "primary" {
  name     = "${var.environment_prefix}-gke-cluster"
  location = var.gcp_region

  # Best Practice: We delete the default node pool and manage it separately
  remove_default_node_pool = true
  initial_node_count       = 1

  # Attach the cluster to our custom VPC
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.subnet.id
  
  # Protects against accidental deletion
  deletion_protection = false 
}

# 2. The Node Pool (The Worker Machines)
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.environment_prefix}-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    machine_type = var.gke_machine_type
    disk_size_gb = 20 # Small disk for practice
    
    # Standard OAuth scopes for GKE nodes
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}