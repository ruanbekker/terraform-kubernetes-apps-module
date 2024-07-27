locals {
  selected_apps = var.apps
}

resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      for i in {1..30}; do
        if curl --silent --insecure --fail ${var.cluster_endpoint}/version; then
          exit 0
        fi
        echo "Waiting for cluster to become available..."
        sleep 10
      done
      echo "Cluster is not available after 30 attempts."
      exit 1
    EOT
  }

  depends_on = [var.cluster_ready_trigger]
}

resource "helm_release" "apps" {
  for_each = zipmap(local.selected_apps, [for app in local.selected_apps : app])

  name             = each.key
  chart            = var.release[each.key].chart
  repository       = var.release[each.key].repository
  version          = var.release[each.key].version
  namespace        = var.release[each.key].namespace
  create_namespace = var.release[each.key].create_namespace
  values           = var.release[each.key].values_file != null ? [file("${path.module}/${var.release[each.key].values_file}")] : []

  depends_on = [null_resource.wait_for_cluster]
}

