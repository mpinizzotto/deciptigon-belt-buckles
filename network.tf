#Get AZ from region us-east-1
data "aws_availability_zones" "azs-east" {
  provider = aws.region-east
  state    = "available"
}

#create vpc in us-east-1
resource "aws_vpc" "vpc-east" {
  provider             = aws.region-east
  cidr_block           = "10.216.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-east"
  }
}

#create igw in us-east-1
resource aws_internet_gateway "igw-east" {
  provider = aws.region-east
  vpc_id   = aws_vpc.vpc-east.id
  tags = {
    Name = "igw-east"
  }
}


##########################################

#Get AZ from region us-west-2
data "aws_availability_zones" "azs-west" {
  provider = aws.region-west
  state    = "available"
}


#create vpc in us-west-2
resource "aws_vpc" "vpc-west" {
  provider             = aws.region-west
  cidr_block           = "10.217.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-west"
  }
}


#create igw in us-west-2
resource aws_internet_gateway "igw-west" {
  provider = aws.region-west
  vpc_id   = aws_vpc.vpc-west.id
  tags = {
    Name = "igw-west"
  }
}

