variable "replicas" {
  default = 1
}

resource "kubernetes_service" "kafka_service" {
  metadata {
    name = "kafka-service"
    labels = {
      app = "kafka-app"
    }
  }

  spec {
    selector = {
      app = "kafka-app"
    }

    port {
      name        = "kafka-port1"
      port        = 9092
      target_port = 9092
      protocol    = "TCP"
    }

    port {
      name        = "kafka-port2"
      port        = 9093
      target_port = 9093
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_stateful_set" "kafka" {
  metadata {
    name = "kafka"
    labels = {
      app = "kafka-app"
    }
  }

  spec {
    service_name = "kafka-service"
    replicas     = var.replicas

    selector {
      match_labels = {
        app = "kafka-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka-app"
        }
      }

      spec {
        container {
          name              = "kafka"
          image             = "docker.io/confluentinc/confluent-local:latest"
          image_pull_policy = "IfNotPresent"

          lifecycle {
            post_start {
              exec {
                command = [
                  "sh",
                  "-c",
                  "kafka-topics --create --topic greetings --partitions 10 --bootstrap-server localhost:9092 || true"
                ]
              }
            }
          }

          port {
            container_port = 29092
          }

          port {
            container_port = 9092
          }

          port {
            container_port = 9093
          }

          env {
            name = "ORDINAL_NUMBER"
            value_from {
              field_ref {
                field_path = "metadata.labels['apps.kubernetes.io/pod-index']"
              }
            }
          }

          env {
            name  = "KAFKA_NODE_ID"
            value = "$(ORDINAL_NUMBER)"
          }

          env {
            name  = "CLUSTER_ID"
            value = "ODhCODhFMjEyNDZCNEI0ME"
          }

          env {
            name  = "POD_NAME"
            value = "kafka-$(ORDINAL_NUMBER)"
          }

          env {
            name  = "KAFKA_LISTENERS"
            value = "CONTROLLER://:29092,PLAINTEXT://:9092,PLAINTEXT_HOST://:9093"
          }

          env {
            name  = "KAFKA_CONTROLLER_QUORUM_VOTERS"
            value = local.kafka_voters
          }

          env {
            name  = "KAFKA_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://localhost:9092,PLAINTEXT_HOST://kafka-service:9093"
          }

          env {
            name  = "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR"
            value = tostring(var.replicas)
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "KAFKA_CONTROLLER_QUORUM_VOTERS" {
  metadata {
    name      = "kafka-controller-quorum-voters"
    namespace = "default"
  }

  data = {
    kafka_voters = local.kafka_voters
  }
}

locals {
  kafka_voters = join(",", [
    for i in range(var.replicas) : "${i}@kafka-${i}.kafka-service.default.svc.cluster.local:29092"
  ])
}