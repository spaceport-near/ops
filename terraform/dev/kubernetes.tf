resource "digitalocean_kubernetes_cluster" "spaceport" {
  name         = "spaceport"
  region       = "nyc1"
  version      = "1.22.12-do.0"
  auto_upgrade = false
  ha           = true

  node_pool {
    name       = "default-pool"
    size       = "s-4vcpu-8gb"
    node_count = 3
  }
}

resource "digitalocean_project" "spaceport" {
  name      = "spaceport"
  resources = [digitalocean_kubernetes_cluster.spaceport.urn]
}
