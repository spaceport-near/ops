variable "backend_mongo_user" {
  description = "Backend Mongo DB user"
  type        = string
  sensitive   = true
}

variable "backend_mongo_password" {
  description = "Backend Mongo DB password"
  type        = string
  sensitive   = true
}
