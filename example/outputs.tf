output "kubeconfig" {
  value     = module.kubernetes.kube_config
  sensitive = true
}
