data "environment_variables" "all" {}

# Get a reference to our *own* workspace ID
data "tfe_workspace" "still_this" {
  organization = local.organization
  name         = terraform.workspace
}
