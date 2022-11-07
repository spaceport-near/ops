resource "digitalocean_kubernetes_cluster" "spaceport" {
  name         = "spaceport"
  region       = "nyc1"
  version      = "1.24.4-do.0"
  auto_upgrade = false
  ha           = true

  node_pool {
    name       = "default-pool"
    size       = "s-4vcpu-8gb"
    node_count = 2
  }
}

resource "digitalocean_project" "spaceport" {
  name      = "spaceport"
  resources = [digitalocean_kubernetes_cluster.spaceport.urn]
}

provider "kubernetes" {
  host                   = digitalocean_kubernetes_cluster.spaceport.endpoint
  token                  = digitalocean_kubernetes_cluster.spaceport.kube_config[0].token
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.spaceport.kube_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.spaceport.endpoint
    token                  = digitalocean_kubernetes_cluster.spaceport.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.spaceport.kube_config[0].cluster_ca_certificate)
  }
}
