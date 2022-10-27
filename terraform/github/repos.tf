module "ops" {
  source  = "mineiros-io/repository/github"
  version = "~> 0.16.2"

  name                = "ops"
  description         = "Devops repo"
  visibility          = "private"
  auto_init           = false
  has_issues          = true
  issue_labels_create = false
  allow_squash_merge  = true
}

module "frontend" {
  source  = "mineiros-io/repository/github"
  version = "~> 0.16.2"

  name                = "frontend"
  description         = "Frontend repo"
  visibility          = "private"
  auto_init           = false
  has_issues          = true
  issue_labels_create = false
  allow_squash_merge  = true
}

module "backend" {
  source  = "mineiros-io/repository/github"
  version = "~> 0.16.2"

  name                = "backend"
  description         = "Docking/undocking repo"
  visibility          = "private"
  auto_init           = false
  has_issues          = true
  issue_labels_create = false
  allow_squash_merge  = true
}
