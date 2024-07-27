# terraform-kubernetes-apps-module

Terraform Module to deploy Helm Apps to your Kubernetes Cluster.

## About

This Terraform module deploys Helm releases to your Kubernetes cluster using the `helm_release` provider. The module defines default configurations for various applications, and you can easily deploy these applications by specifying them in the `apps` list. If you need to override the default values, you can provide your own values file.

## Features

- Deploy multiple Helm releases by specifying their names.
- Use default configurations or provide custom values.
- Automatically creates namespaces if specified.

## Applications Available

A list of available apps can be found in the variable `release` defined in [./variables.tf](./variables.tf).

To install them, you can pass them to the `apps` list variable, for a example see [examples](#example).

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.apps](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.wait_for_cluster](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | List of apps that will be deployed. | `list(string)` | `[]` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | The endpoint of the Kubernetes cluster. | `string` | `null` | no |
| <a name="input_cluster_ready_trigger"></a> [cluster\_ready\_trigger](#input\_cluster\_ready\_trigger) | A trigger to indicate the Kubernetes cluster is ready. | `any` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | n/a | <pre>map(object({<br>    chart            = string<br>    repository       = string<br>    version          = string<br>    namespace        = string<br>    create_namespace = bool<br>    values_file      = string<br>  }))</pre> | <pre>{<br>  "whoami": {<br>    "chart": "whoami",<br>    "create_namespace": true,<br>    "namespace": "apps",<br>    "repository": "https://cowboysysop.github.io/charts/",<br>    "values_file": "templates/whoami/values.yaml",<br>    "version": "5.1.1"<br>  }<br>}</pre> | no |

## Outputs

No outputs.

## Example

You can see a full example at [./example/](./example/).

```hcl
module "kubernetes" {
  source  = "git::https://github.com/ruanbekker/terraform-kubernetes-vultr-module.git?ref=stable"

  cluster_name    = "test-cluster"
  cluster_version = "v1.29.4+1"
}

module "apps" {
  source = "../"

  apps = [
    "whoami"
  ]

  cluster_endpoint       = module.kubernetes.endpoint
  cluster_ready_trigger  = module.kubernetes

}
```
