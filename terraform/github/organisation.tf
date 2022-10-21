data "github_organization" "spaceport_near" {
  name = "spaceport-near"
}

module "organization" {
  source  = "mineiros-io/organization/github"
  version = "~> 0.7.0"

  members = [
    "Motzart",
  ]

  admins = [
    "inc4-deployer",
    "valar999",
    "segovchik",
    "olehbandrivskyi",
    "kuroneko-ua",
  ]

  blocked_users = [
  ]

}
