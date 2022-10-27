module "devops" {
  source  = "mineiros-io/team/github"
  version = "~> 0.8.0"

  name        = "devops"
  description = "The DevOps Team"
  privacy     = "secret"

  maintainers = [
    "segovchik"
  ]

  members = [
    "olehbandrivskyi",
    "ozhadaie"
  ]

  push_repositories = [
    module.ops.repository.name,
  ]
}

module "frontend_admins" {
  source  = "mineiros-io/team/github"
  version = "~> 0.8.0"

  name        = "frontend-admins"
  description = "The Frontend Admins Team"
  privacy     = "secret"

  members = [
    "motzart"
  ]

  admin_repositories = [
    module.frontend.repository.name
  ]
}

module "backend_admins" {
  source  = "mineiros-io/team/github"
  version = "~> 0.8.0"

  name        = "backend-admins"
  description = "The Backend Admins Team"
  privacy     = "secret"

  members = [
    "mephistopheles1010",
    "valar999"
  ]

  admin_repositories = [
    module.backend.repository.name
  ]
}
