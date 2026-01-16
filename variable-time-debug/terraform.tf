terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    external = {
      source  = "hashicorp/external"
      version = "~>2.3"
    }
  }
}