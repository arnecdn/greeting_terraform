terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path    = var.kube_config_path
  config_context = var.kube_config_context
}

module "kafka" {
  source   = "./modules/kafka"
  replicas = var.kafka_cluster_replicas
}

