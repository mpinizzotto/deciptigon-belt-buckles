


resource "aws_route53_record" "blog." {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "blog.mpinizzotto.com"
  type    = "A"
  ttl     = "300"

  weighted_routing_policy {
    weight = 100
  }

  set_identifier = "blog-east"
  records        = ["aws_elb."]
}

resource "aws_route53_record" "blog." {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "blog"
  type    = "A"
  ttl     = "300"

  weighted_routing_policy {
    weight = 100
  }

  set_identifier = "blog-west"
  records        = ["blog.mpinizzotto.com"]
}
