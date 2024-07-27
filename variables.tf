variable "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster."
  type        = string
  default     = null
}

variable "cluster_ready_trigger" {
  description = "A trigger to indicate the Kubernetes cluster is ready."
  type        = any
}

variable "apps" {
  description = "List of apps that will be deployed."
  type        = list(string)
  default     = []
}

variable "release" {
  type = map(object({
    chart            = string
    repository       = string
    version          = string
    namespace        = string
    create_namespace = bool
    values_file      = string
  }))
  default = {
    argo-cd = {
      chart            = "argo-cd"
      repository       = "https://argoproj.github.io/argo-helm"
      version          = "7.3.11"
      namespace        = "apps"
      create_namespace = true
      values_file      = "templates/argo-cd/values.yaml"
    }
    kube-prometheus-stack = {
      chart            = "kube-prometheus-stack"
      repository       = "https://prometheus-community.github.io/helm-charts"
      version          = "61.4.0"
      namespace        = "apps"
      create_namespace = true
      values_file      = "templates/kube-prometheus-stack/values.yaml"
    }
    whoami = {
      chart            = "whoami"
      repository       = "https://cowboysysop.github.io/charts/"
      version          = "5.1.1"
      namespace        = "apps"
      create_namespace = true
      values_file      = "templates/whoami/values.yaml"
    }
    # More will be added here.
  }
}

