# Configure the DigitalOcean provider
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0" 
    }
  }
}

provider "digitalocean" {
  token = var.do_token 
}

# Define a Virtual Private Cloud (VPC) in DigitalOcean
resource "digitalocean_vpc" "app_vpc" {
  name   = "app-vpc-${var.cluster_name}"
  region = var.region
}

# Define a DigitalOcean Kubernetes Cluster, linking it to the VPC
resource "digitalocean_kubernetes_cluster" "doks_cluster" {
  name     = var.cluster_name
  region   = var.region
  version  = "1.34.1-do.0"
  vpc_uuid = digitalocean_vpc.app_vpc.id

  node_pool {
    name       = "worker-pool"
    size       = var.node_size
    node_count = var.node_count
  }
}

# Define a firewall and attach it to the DOKS node pool
resource "digitalocean_firewall" "cluster_firewall" {
  name = "k8s-firewall-${digitalocean_kubernetes_cluster.doks_cluster.name}"

  # Attach to the worker nodes using the cluster's unique ID tag
  tags = [
    "k8s:${digitalocean_kubernetes_cluster.doks_cluster.id}"
  ]

  # Explicitly wait for the cluster creation to finish
  depends_on = [
    digitalocean_kubernetes_cluster.doks_cluster
  ]

  # Allow incoming SSH (port 22) for potential debugging (optional)
  inbound_rule {
    protocol          = "tcp"
    port_range        = "22"
    source_addresses  = [var.my_ip_address]
  }

  # Allow inbound HTTP/HTTPS from everywhere (for Load Balancer)
  inbound_rule {
    protocol    = "tcp"
    port_range  = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol    = "tcp"
    port_range  = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Define a DigitalOcean Container Registry
resource "digitalocean_container_registry" "app_registry" {
  name = "kelly-app-registry-temp" 
  region = var.region
  subscription_tier_slug = "starter" 
}