terraform {
  required_version = ">= 1.3.3"

  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}

provider "github" {
  owner = "spaceport-near"
}
