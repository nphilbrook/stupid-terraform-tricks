# Get a reference to our *own* workspace ID if we know the org name offhand
locals {
  organization = "philbrook"
}

data "tfe_workspace" "this" {
  organization = local.organization
  name         = terraform.workspace
}

output "this_ws_id" {
  value = data.tfe_workspace.this.id
}

# An alternate approach - don't need the local.organization

# Automatically provided from HCP Terraform, BUT ONLY if this is a root module
variable "TFC_WORKSPACE_SLUG" {
  type = string
}

locals {
  ws_parts = split("/", var.TFC_WORKSPACE_SLUG)
}

data "tfe_workspace" "also_this" {
  organization = local.ws_parts[0]
  name         = local.ws_parts[1]
}

output "also_this_ws_id" {
  value = data.tfe_workspace.also_this.id
}
