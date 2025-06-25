# This Terraform configuration sets up a Kubernetes provider and a Kafka module.
# It is a multi-file setup with a main configuration file, a module for Kafka, and variable definitions.

# root - defines the main configuration
# modules/kafka - defines the Kafka module with its own provider and variables


terraform {
  required_version = ">= 1.0.0"

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
  kafka_replicas = var.kafka_cluster_replicas
}

