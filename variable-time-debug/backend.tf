terraform {
  cloud {
    hostname     = "tfe-pi-new.nick-philbrook.sbx.hashidemos.io"
    organization = "philbrook-tfe"
    workspaces {
      name = "stupid-terraform-tricks-variable-time-debug"
    }
  }
}