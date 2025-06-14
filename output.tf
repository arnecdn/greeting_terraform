output "kafka_service_name" {
  description = "Name of the Kafka service"
  value       = module.kafka.kafka_service_name
}

output "kafka_statefulset_name" {
  description = "Name of the Kafka service"
  value       = module.kafka.kafka_stateful_set_name
}