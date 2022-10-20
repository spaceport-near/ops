terraform {
  required_version = ">= 1.3.3"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "inc4"

    workspaces {
      name = "spaceport-github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}

provider "github" {
  owner = "spaceport-near"
}
