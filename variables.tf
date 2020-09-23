variable "profile" {
  description = "aws cli profile"
  default     = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "east" {
  default = "us-east-1"
}

variable "west" {
  default = "us-west-2"
}

variable "external-ip" {
  default = "0.0.0.0/0"
}

variable "public-key-path" {
  default = "/home/cloud_user/.ssh/id_rsa.pub"
}
