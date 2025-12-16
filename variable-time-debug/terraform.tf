terraform {
  required_providers {
    random = {
      source  = "tfe-pi-new.nick-philbrook.sbx.hashidemos.io/philbrook-tfe/random"
      version = "3.7.2"
    }
    external = {
      source  = "hashicorp/external"
      version = "~>2.3"
    }
  }
}