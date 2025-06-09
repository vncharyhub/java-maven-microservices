output "cluster_name" {
  value = module.eks.cluster_name
}
output "kubeconfig_raw" {
  value     = module.eks.kubeconfig
  sensitive = true
}
