#compute

data "aws_ami" "ami-east" {
  provider = aws.region-east
  most_recent = true
  owners = ["099720109477"]
  
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-*"]
  }
}

data "aws_ami" "ami-west" {
  provider = aws.region-west
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-*"]
  }
}

resource "aws_key_pair" "project-keys" {
  provider = aws.region-east
  key_name = "project-keys"
  public_key = file(var.public-key-path)
}

resource "aws_instance" "instance-east" {
  provider = aws.region-east
  instance_type = "t2.micro" 
  ami = data.aws_ami.ami-east.id
  tags = {
    Name = "ghost-01"
  }
  key_name = aws_key_pair.project-keys.id
  vpc_security_group_ids = [aws_security_group.web-sg-east.id]
  subnet_id = aws_subnet.subnet-east-1.id
}
