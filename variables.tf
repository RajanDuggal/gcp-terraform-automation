variable "project_id" {
  description = "The GCP Project ID where resources will be deployed"
  type        = string
}

variable "gcp_region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1" # If no value is provided, it defaults to this
}

variable "environment_prefix" {
  description = "Prefix for naming resources (e.g., dev, prod, globant-prep)"
  type        = string
}
variable "gke_num_nodes" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "gke_machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
  default     = "e2-small" # Keeping it small to save costs
}