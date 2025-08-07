variable "postgres_db" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "greeting_rust"
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "greeting_rust"
}

variable "postgres_password" {
  description = "Base64-encoded PostgreSQL password"
  type        = string
  default     = "Z3JlZXRpbmdfcnVzdAo="
}