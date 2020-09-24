
data "aws_availability_zones" "azs-east" {
  provider = aws.region-east
  state    = "available"
}


resource "aws_vpc" "vpc-east" {
  provider             = aws.region-east
  cidr_block           = "10.216.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-east"
  }
}


resource aws_internet_gateway "igw-east" {
  provider = aws.region-east
  vpc_id   = aws_vpc.vpc-east.id
  tags = {
    Name = "igw-east"
  }
}


resource "aws_subnet" "subnet-east" {
  provider          = aws.region-east
  count             = 2
  availability_zone = data.aws_availability_zones.azs-east.names[count.index]
  vpc_id            = aws_vpc.vpc-east.id
  cidr_block        = ["10.216.1.0/24", "10.216.2.0/24"][count.index]
  tags = {
    Name = "subnet-${count.index + 1}-east"
  }
}

resource "aws_route_table" "east-rt" {
  provider = aws.region-east
  vpc_id   = aws_vpc.vpc-east.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-east.id
  }
  route {
    cidr_block                = "10.217.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "east-rt"
  }
}

resource "aws_main_route_table_association" "default-rt-association-east" {
  provider       = aws.region-east
  vpc_id         = aws_vpc.vpc-east.id
  route_table_id = aws_route_table.east-rt.id
}

############################################################


data "aws_availability_zones" "azs-west" {
  provider = aws.region-west
  state    = "available"
}


resource "aws_vpc" "vpc-west" {
  provider             = aws.region-west
  cidr_block           = "10.217.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-west"
  }
}


resource aws_internet_gateway "igw-west" {
  provider = aws.region-west
  vpc_id   = aws_vpc.vpc-west.id
  tags = {
    Name = "igw-west"
  }
}


resource "aws_subnet" "subnet-west" {
  provider          = aws.region-west
  count             = 2
  availability_zone = data.aws_availability_zones.azs-west.names[count.index]
  vpc_id            = aws_vpc.vpc-west.id
  cidr_block        = ["10.217.1.0/24", "10.217.2.0/24"][count.index]
  tags = {
    Name = "subnet-${count.index + 1}-west"
  }
}


resource "aws_route_table" "west-rt" {
  provider = aws.region-west
  vpc_id   = aws_vpc.vpc-west.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-west.id
  }
  route {
    cidr_block                = "10.216.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "west-rt"
  }
}

resource "aws_main_route_table_association" "default-rt-association-west" {
  provider       = aws.region-west
  vpc_id         = aws_vpc.vpc-west.id
  route_table_id = aws_route_table.west-rt.id
}


################################################################


#vpc peering between us-east-1 and us-west-2
resource "aws_vpc_peering_connection" "vpc-peering" {
  provider    = aws.region-east
  peer_vpc_id = aws_vpc.vpc-west.id
  vpc_id      = aws_vpc.vpc-east.id
  peer_region = var.west
}

#vpc peering acceptance 
resource "aws_vpc_peering_connection_accepter" "vpc-acceptance" {
  provider                  = aws.region-west
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering.id
  auto_accept               = true
}





