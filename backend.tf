terraform {
  cloud {

    organization = "philbrook"

    workspaces {
      name = "test-data-env"
    }
  }
}
