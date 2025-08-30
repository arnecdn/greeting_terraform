The README.md file for setting up Kubernetes with the nescessary 
Greeting infrastructure.


# Postgres Module
This Terraform module deploys a Postgres server on Kubernetes. 


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.11.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ./modules/postgres | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kube_config_context"></a> [kube\_config\_context](#input\_kube\_config\_context) | Kubernetes context to use | `string` | `"minikube"` | no |
| <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path) | Path to the Kubernetes config file | `string` | `"~/.kube/config"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->