terraform {
  cloud {

    organization = "philbrook"

    workspaces {
      name = "stupid-terraform-tricks"
    }
  }
}
