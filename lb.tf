
resource "aws_lb" "lb-east" {
  provider           = aws.region-east
  name               = "lb-east"
  subnets            = aws_subnet.subnet-east.*.id
  security_groups    = [aws_security_group.lb-sg-east.id]
  ip_address_type    = "ipv4"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  #  access_logs {
  #    bucket  = aws_s3_bucket.lb_logs.bucket
  #    prefix  = "LB-East-"
  #    enabled = true
  #  }

  tags = {
    Name = "lb-east"
  }
}

resource "aws_lb_target_group" "lb-tg-east" {
  provider = aws.region-east
  name     = "lb-tg-east"
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

resource "aws_lb_target_group_attachment" "lb-tg-east" {
  provider         = aws.region-east
  count            = var.instance-count
  target_group_arn = aws_lb_target_group.lb-tg-east.arn
  target_id        = aws_instance.instance-east.*.id[count.index]
  port             = 8080
}


resource "aws_lb_listener" "lb-east" {
  provider          = aws.region-east
  load_balancer_arn = aws_lb.lb-east.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-east.arn
  }
}

###########################################################


resource "aws_lb" "lb-west" {
  provider           = aws.region-west
  name               = "lb-west"
  subnets            = aws_subnet.subnet-west.*.id
  security_groups    = [aws_security_group.lb-sg-west.id]
  ip_address_type    = "ipv4"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  #  access_logs {
  #    bucket  = aws_s3_bucket.lb_logs.bucket
  #    prefix  = "LB-West-"
  #    enabled = true
  #  }

  tags = {
    Name = "lb-west"
  }
}

resource "aws_lb_target_group" "lb-tg-west" {
  provider = aws.region-west
  name     = "lb-tg-west"
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

resource "aws_lb_target_group_attachment" "lb-tg-west" {
  provider         = aws.region-west
  count            = var.instance-count
  target_group_arn = aws_lb_target_group.lb-tg-west.arn
  target_id        = aws_instance.instance-west.*.id[count.index]
  port             = 8080
}


resource "aws_lb_listener" "lb-west" {
  provider          = aws.region-west
  load_balancer_arn = aws_lb.lb-west.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-west.arn
  }
}

