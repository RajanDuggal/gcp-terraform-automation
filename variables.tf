# ------------------------------------------------------------------------------
# CORE INFRASTRUCTURE VARIABLES
# ------------------------------------------------------------------------------

variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
  # No default on purpose - this MUST be passed securely via GitHub Actions YAML
}

variable "gcp_region" {
  type        = string
  description = "The Google Cloud region to deploy resources in"
  default     = "us-east1"
}

variable "gcp_zone" {
  type        = string
  description = "The specific zone within the region"
  default     = "us-east1-b"
}

variable "environment_prefix" {
  type        = string
  description = "Prefix for naming resources (e.g., dev, prod, globant-prep)"
  default     = "globant-prep"
}

# ------------------------------------------------------------------------------
# NETWORK VARIABLES
# ------------------------------------------------------------------------------

variable "vpc_name" {
  type        = string
  description = "Name of the Virtual Private Cloud network"
  default     = "main-vpc"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the primary subnet"
  default     = "10.0.0.0/16"
}

# ------------------------------------------------------------------------------
# KUBERNETES (GKE) VARIABLES
# ------------------------------------------------------------------------------

variable "gke_cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
  default     = "primary-cluster"
}

variable "gke_machine_type" {
  type        = string
  description = "The machine type for the GKE nodes"
  default     = "e2-medium"
}

variable "gke_num_nodes" {
  type        = number
  description = "Number of worker nodes in the GKE cluster"
  default     = 1
}
