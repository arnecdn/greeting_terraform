# terraform {
#   required_providers {
#
#     kubernetes = {
#       source = "hashicorp/kubernetes"
#       version = "2.11.0"
#     }
#   }
# }
#
# provider "kubernetes" {
#   config_path    = var.kube_config_path
#   config_context = "minikube"
# }
#
# variable "kube_config_path" {
#   default = "~/.kube/config"
# }

