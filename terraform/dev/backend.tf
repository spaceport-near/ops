resource "helm_release" "backend" {
  name  = "spaceport"
  chart = "../../helm/backend"
}