# The DigitalOcean API token. This is marked as sensitive and is provided
# via an environment variable (TF_VAR_do_token). 
variable "do_token" {
  description = "DigitalOcean Personal Access Token (PAT)"
  type        = string
  sensitive = true
}

# DigitalOcean Kubernetes Service (DOKS) cluster name
variable "cluster_name" {
  description = "A unique name for the DOKS cluster."
  type        = string
  default     = "temp-doks-cluster"
}

# Region to deploy the VPC and DOKS cluster
variable "region" {
  description = "The DigitalOcean region to deploy resources (e.g., nyc1, fra1)."
  type        = string
  default     = "nyc3" 
}

# Kubernetes node pool configuration
variable "node_size" {
  description = "The slug for the Droplet size to use for the worker nodes (e.g., s-2vcpu-2gb)."
  type        = string
  default     = "s-2vcpu-2gb" 
}

# Number of nodes in the default node pool
variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 2 
}

variable "k8s_version" {
  description = "The Kubernetes version to use."
  type        = string
  # Use a recent, stable version
  default     = "1.34" 
}

# The name for the DigitalOcean Container Registry
variable "registry_name" {
  description = "The unique slug name for the DigitalOcean Container Registry (DOCR)."
  type        = string
  default     = "temp-registry-slug" 
}

# My public IP address to restrict SSH access in the firewall rules
variable "my_ip_address" {
  description = "Current public IP address to allow SSH access (e.g., 102.88.113.157/32)."
  type        = string
}