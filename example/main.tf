module "kubernetes" {
  source  = "git::https://github.com/ruanbekker/terraform-kubernetes-vultr-module.git?ref=stable"

  cluster_name    = "test-cluster"
  cluster_version = "v1.29.4+1"
}

# local kubernetes option
# 
# module "kubernetes" {
#   source = "git::https://github.com/ruanbekker/terraform-kubernetes-kind-module.git?ref=main"

#   cluster_name    = "test-cluster"
# }

module "apps" {
  source = "../"
  
  apps = [
    "whoami",
    "argo-cd"
  ]

  cluster_endpoint       = module.kubernetes.endpoint
  cluster_ready_trigger  = module.kubernetes

}

