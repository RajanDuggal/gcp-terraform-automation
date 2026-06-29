output "vpc_id" {
  description = "The unique ID of the created VPC network"
  value       = google_compute_network.vpc_network.id
}

output "subnet_gateway_ip" {
  description = "The gateway IP address of the created subnetwork"
  value       = google_compute_subnetwork.subnet.gateway_address
}

output "kubernetes_connection_command" {
  description = "Command to connect to the GKE cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${var.gcp_region} --project ${var.project_id}"
}