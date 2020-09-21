terraform {
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "terraform/terraformstate"
    bucket  = "deciptigon-bucket"
  }
}
