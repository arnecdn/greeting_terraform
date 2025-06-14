variable "kube_config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_config_context" {
  description = "Kubernetes context to use"
  type        = string
  default     = "minikube"
}

variable "kafka_cluster_replicas" {
  description = "Number of Kafka replicas"
  type        = number
  default     = 1
}

