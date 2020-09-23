#compute

data "aws_ami" "ami-east" {
  provider    = aws.region-east
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-*"]
  }
}

data "aws_ami" "ami-west" {
  provider    = aws.region-west
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-*"]
  }
}

data "template_file" "user-init" {
  template = file("userdata.tpl")
}

resource "aws_key_pair" "project-keys-east" {
  provider   = aws.region-east
  key_name   = "project-keys"
  public_key = file(var.public-key-path)
}

resource "aws_instance" "instance-east" {
  provider      = aws.region-east
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami-east.id
  tags = {
    Name = "ghost-01"
  }
  key_name                    = aws_key_pair.project-keys-east.id
  vpc_security_group_ids      = [aws_security_group.web-sg-east.id]
  subnet_id                   = aws_subnet.subnet-east-1.id
  associate_public_ip_address = true
  user_data                   = data.template_file.user-init.rendered
}

resource "aws_key_pair" "project-keys-west" {
  provider   = aws.region-west
  key_name   = "project-keys"
  public_key = file(var.public-key-path)
}

resource "aws_instance" "instance-west" {
  provider      = aws.region-west
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami-west.id
  tags = {
    Name = "ghost-02"
  }
  key_name                    = aws_key_pair.project-keys-west.id
  vpc_security_group_ids      = [aws_security_group.web-sg-west.id]
  subnet_id                   = aws_subnet.subnet-west-2.id
  associate_public_ip_address = true
  user_data                   = data.template_file.user-init.rendered
}













