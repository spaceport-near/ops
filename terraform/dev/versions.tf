terraform {
  required_version = ">= 1.3.3"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "inc4"

    workspaces {
      name = "spaceport-dev"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.21.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
}
