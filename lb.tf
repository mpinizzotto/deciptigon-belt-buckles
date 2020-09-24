resource "aws_lb" "lb-east" {
  provider           = aws.region-east
  name               = "lb-east"
  subnets            = aws_subnet.subnet-east-1.*.id
  security_groups    = [aws_security_group.lb-sg-east.id]
  ip_address_type    = "ipv4"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  #  access_logs {
  #    bucket  = aws_s3_bucket.lb_logs.bucket
  #    prefix  = "test-lb"
  #    enabled = true
  #  }

  tags = {
    Name = "lb-east"
  }
}

resource "aws_lb_target_group" "lb-east" {
  name     = "tg-east"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-east.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "lb-east" {
  count            = var.instance-count
  target_group_arn = aws_lb_target_group.lb-east.arn
  target_id        = aws_instance.instance-east.*.id[count.index]
  port             = 8080
}


resource "aws_lb_listener" "lb-east" {
  load_balancer_arn = aws_lb.lb-east.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-east.arn
  }
}

############################################################


resource "aws_lb" "lb-west" {
  provider           = aws.region-west
  name               = "lb-west"
  subnets            = aws_subnet.subnet-west-2.*.id
  security_groups    = [aws_security_group.lb-sg-west.id]
  ip_address_type    = "ipv4"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  #  access_logs {
  #    bucket  = aws_s3_bucket.lb_logs.bucket
  #    prefix  = "test-lb"
  #    enabled = true
  #  }

  tags = {
    Name = "lb-west"
  }
}

resource "aws_lb_target_group" "lb-west" {
  name     = "tg-west"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-west.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "lb-west" {
  count            = var.instance-count
  target_group_arn = aws_lb_target_group.lb-west.arn
  target_id        = aws_instance.instance-west.*.id[count.index]
  port             = 8080
}


resource "aws_lb_listener" "lb-west" {
  load_balancer_arn = aws_lb.lb-west.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-west.arn
  }
}

















