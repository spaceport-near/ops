data "kubernetes_ingress_v1" "backend" {
  metadata {
    name      = "ingress-nginx"
    namespace = "default"
  }
}

resource "helm_release" "backend" {
  name  = "spaceport"
  chart = "../../helm/backend"

  # spaceport image version
  set {
    name  = "backend.imageSpaceport.tag"
    type  = "string"
    value = "develop"
  }
  
  # ENV variables
  set {
    name  = "backend.env.NODE_ENV"
    type  = "string"
    value = "development"
  }

  set {
    name  = "backend.env.CORS_ALLOWED_ORIGINS"
    type  = "string"
    value = "https://app.launchspaceport.io http://localhost:3000 http://127.0.0.1 https://127.0.0.1 https://127.0.0.1 http://localhost https://localhost"
  }

  # mongodb config
  set {
    name  = "backend.env.MONGODB_URL"
    type  = "string"
    value = mongodbatlas_serverless_instance.spaceport.connection_strings_standard_srv
  }

  set_sensitive {
    name  = "backend.secrets.mongodb_user"
    value = var.backend_mongo_user
  }

  set_sensitive {
    name  = "backend.secrets.mongodb_pass"
    value = var.backend_mongo_password
  }
}

resource "kubernetes_ingress_v1" "nginx" {
  wait_for_load_balancer = true
  metadata {
    name      = "ingress-nginx"
    namespace = "default"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.backend_url
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "spaceport-backend"
              port {
                number = 8877
              }
            }
          }
        }
      }
    }
  }
}
