resource "mongodbatlas_project" "spaceport" {
  name   = var.mongodbatlas_project_name
  org_id = var.mongodbatlas_org_id
}

resource "mongodbatlas_project_ip_access_list" "full" {
  project_id = mongodbatlas_project.spaceport.id
  cidr_block = "0.0.0.0/0"
  comment    = "ip address for full access"
}

resource "mongodbatlas_project_ip_access_list" "backend" {
  project_id = mongodbatlas_project.spaceport.id
  ip_address = data.kubernetes_ingress_v1.backend.status.0.load_balancer.0.ingress.0.ip
  comment    = "ip address for backend access"
}

resource "mongodbatlas_serverless_instance" "spaceport" {
  project_id = mongodbatlas_project.spaceport.id
  name       = var.monogodbatlas_instance_name

  provider_settings_backing_provider_name = "GCP"
  provider_settings_provider_name         = "SERVERLESS"
  provider_settings_region_name           = "WESTERN_EUROPE"
}

resource "mongodbatlas_database_user" "admin" {
  username           = var.backend_mongo_user
  password           = var.backend_mongo_password
  project_id         = mongodbatlas_project.spaceport.id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

resource "mongodbatlas_database_user" "mephistopheles" {
  username           = var.mephistopheles_mongo_user
  password           = var.mephistopheles_mongo_password
  project_id         = mongodbatlas_project.spaceport.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "test"
  }
}
