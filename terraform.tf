terraform {
  required_version = ">=1.12"
  required_providers {
    environment = {
      source  = "EppO/environment"
      version = "~>1.3"
    }
  }
}
