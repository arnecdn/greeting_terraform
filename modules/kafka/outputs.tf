output "kafka_service_name" {
  value = kubernetes_service.kafka_service.metadata[0].name
}

output "kafka_stateful_set_name" {
  value = kubernetes_stateful_set.kafka.metadata[0].name
}