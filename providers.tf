provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  profile = var.profile
  region  = var.east
  alias   = "region-east"
}

provider "aws" {
  profile = var.profile
  region  = var.west
  alias   = "region-west"
}
