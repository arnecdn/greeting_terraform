The README.md file for setting up Kubernetes with the nescessary 
Greeting infrastructure.


# Kafka Module
This Terraform module deploys a Kafka cluster on Kubernetes. It allows you to configure the number of replicas and provides outputs for the service and statefulset names.

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
| <a name="module_kafka"></a> [kafka](#module\_kafka) | ./modules/kafka | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kafka_cluster_replicas"></a> [kafka\_cluster\_replicas](#input\_kafka\_cluster\_replicas) | Number of Kafka replicas | `number` | `1` | no |
| <a name="input_kube_config_context"></a> [kube\_config\_context](#input\_kube\_config\_context) | Kubernetes context to use | `string` | `"minikube"` | no |
| <a name="input_kube_config_path"></a> [kube\_config\_path](#input\_kube\_config\_path) | Path to the Kubernetes config file | `string` | `"~/.kube/config"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kafka_service_name"></a> [kafka\_service\_name](#output\_kafka\_service\_name) | Name of the Kafka service |
| <a name="output_kafka_statefulset_name"></a> [kafka\_statefulset\_name](#output\_kafka\_statefulset\_name) | Name of the Kafka service |
<!-- END_TF_DOCS -->