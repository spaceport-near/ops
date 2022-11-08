variable "backend_mongo_user" {
  description = "Backend MongoDB user"
  type        = string
}

variable "backend_mongo_password" {
  description = "Backend MongoDB password"
  type        = string
  sensitive   = true
}

variable "mongodbatlas_project_name" {
  description = "MongoDB Atlas project name"
  type        = string
  default     = "spaceport"
}

variable "monogodbatlas_instance_name" {
  description = "MongoDB Atlas instance name"
  type        = string
  default     = "dev"
}

variable "mongodbatlas_org_id" {
  description = "MongoDBatlas organization id"
  type        = string
}

variable "grafana_password" {
  description = "Default grafana password for admin user"
  type        = string
}

variable "grafana_url" {
  default = "grafana.launchspaceport.io"
  type    = string
}

variable "grafana_github_oauth_client_id" {
  description = "GitHub OAuth App, client ID"
  type        = string
}

variable "grafana_github_oauth_client_secret" {
  description = "GitHub OAuth App, client secret"
  type        = string
  sensitive   = true
}

variable "prometheus_url" {
  default = "prometheus.launchspaceport.io"
  type    = string
}

variable "prometheus_github_oauth_client_id" {
  description = "GitHub OAuth App, client ID"
  type        = string
}

variable "prometheus_github_oauth_client_secret" {
  description = "GitHub OAuth App, client secret"
  type        = string
  sensitive   = true
}

variable "alertmanager_url" {
  default = "alertmanager.launchspaceport.io"
  type    = string
}

variable "alertmanager_github_oauth_client_id" {
  description = "GitHub OAuth App, client ID"
  type        = string
}

variable "alertmanager_github_oauth_client_secret" {
  description = "GitHub OAuth App, client secret"
  type        = string
  sensitive   = true
}

variable "monitoring_namespace" {
  default = "monitoring"
  type    = string
}
