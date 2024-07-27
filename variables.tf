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

