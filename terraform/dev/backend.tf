resource "helm_release" "backend" {
  name  = "spaceport"
  chart = "../../helm/backend"

  set {
    name  = "backend.env.MONGODB_URL"
    type  = "string"
    value = "mongodb+srv://db-mongodb-fra1-03587-580724cb.mongo.ondigitalocean.com/admin"
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
