terraform {
  backend "s3" {
    required_version = "=< 0.12.0"
    region           = "us-east-1"
    profile          = "default"
    key              = "terraform/terraform.tfstate"
    bucket           = "deciptigon-bucket"
  }
}
