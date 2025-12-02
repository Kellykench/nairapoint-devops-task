# Output the name assigned to the Kubernetes cluster
output "cluster_name" {
  value = digitalocean_kubernetes_cluster.doks_cluster.name
}

# Output the full Kubernetes configuration file data (the Kubeconfig)
output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.doks_cluster.kube_config.0.raw_config
  sensitive = true
}