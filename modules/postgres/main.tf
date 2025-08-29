resource "kubernetes_deployment" "postgres_greeting" {
  metadata {
    name = "postgres-greeting"
    labels = {
      app = "postgres-greeting"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "postgres-greeting"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres-greeting"
        }
      }

      spec {
        container {
          name  = "postgres-greeting"
          image = "docker.io/library/postgres:16.1"

          port {
            container_port = 5432
          }
          volume_mount {
            name       = "postgres-data"
            mount_path = "/var/lib/postgresql/data"
          }

          env {
            name = "POSTGRES_DB"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.postgres_greeting_config.metadata[0].name
                key  = "POSTGRES_DB"
              }
            }
          }

          env {
            name = "POSTGRES_USER"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.postgres_greeting_config.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.postgres_greeting_secret.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }
        }
        volume {
          name = "postgres-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.postgres_greeting_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres_greeting" {
  metadata {
    name = "postgres-greeting"
  }

  spec {
    selector = {
      app = "postgres-greeting"
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_persistent_volume_claim" "postgres_greeting_pvc" {
  metadata {
    name = "postgres-greeting-pvc"
    labels = {
      app = "postgres-greeting"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "kubernetes_config_map" "postgres_greeting_config" {
  metadata {
    name = "postgres-greeting-config"
    labels = {
      app = "postgres-greeting"
    }
  }

  data = {
    POSTGRES_DB   = var.postgres_db
    POSTGRES_USER = var.postgres_user
    POSTGRES_HOST = var.postgres_db
  }
}

resource "kubernetes_secret" "postgres_greeting_secret" {
  metadata {
    name = "postgres-greeting-secret"
    labels = {
      app = "postgres-greeting"
    }
  }

  data = {
    POSTGRES_PASSWORD = var.postgres_password
  }
}