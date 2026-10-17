terraform {
  backend "s3" {
    bucket       = "stag-postgrestore-terraform-remote-backend"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
    encrypt      = true
  }
}