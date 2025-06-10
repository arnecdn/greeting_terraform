terraform {
  required_providers {
    
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path    = var.kube_config_path
  config_context = "minikube"
}

variable "kube_config_path" {
  default = "~/.kube/config"
}

data "kubernetes_config_map" "KAFKA_CONTROLLER_QUORUM_VOTERS" {
  metadata {
    name      = "kafka-controller-quorum-voters"
    namespace = "default"
  }
}