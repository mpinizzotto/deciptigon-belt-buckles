variable "profile" {
  description = "aws cli profile"
  default     = "default"
}

variable "region" {
  description = "default region"
  default     = "us-east-1"
}

variable "east" {
  default = "us-east-1"
}

variable "west" {
  default = "us-west-1"
}

variable "external-ip" {
  default = "0.0.0.0/0"
}

variable "public-key-path" {
  default = "/home/cloud_user/.ssh/id_rsa.pub"
}

variable "instance-count" {
  description = "compute instance per region"
  default     = 1
}
