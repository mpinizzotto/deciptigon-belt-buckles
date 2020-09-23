#securitygroups.tf

resource "aws_security_group" "lb-sg-east" {
  provider    = aws.region-east
  name        = "lb-sg-east"
  description = "Allow traffic to elb"
  vpc_id      = aws_vpc.vpc-east.id

  ingress {
    description = "Allow 443 to lb"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http to lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow lb outbound to inet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-sg-east" {
  provider    = aws.region-east
  name        = "web-sg-east"
  description = "Allow traffic to and from Web server"
  vpc_id      = aws_vpc.vpc-east.id

  ingress {
    description = "Allow SSH to server for mgmt"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external-ip]
  }

  ingress {
    description = "Allow traffic from lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb-sg-east.id]
  }

  ingress {
    description = "Allow traffic from us-west-2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.217.0.0/16"]
  }

  egress {
    description = "Allow server outbound to inet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "lb-sg-west" {
  provider    = aws.region-west
  name        = "lb-sg-west"
  description = "Allow traffic to elb"
  vpc_id      = aws_vpc.vpc-west.id

  ingress {
    description = "Allow 443 to lb"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http to lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow lb outbound to inet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-sg-west" {
  provider    = aws.region-west
  name        = "web-sg-west"
  description = "Allow traffic to and from Web server"
  vpc_id      = aws_vpc.vpc-west.id

  ingress {
    description = "Allow SSH to server for mgmt"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external-ip]
  }

  ingress {
    description = "Allow traffic from lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb-sg-west.id]
  }

  ingress {
    description = "Allow traffic from us-east-1"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.216.0.0/16"]
  }

  egress {
    description = "Allow server outbound to inet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
