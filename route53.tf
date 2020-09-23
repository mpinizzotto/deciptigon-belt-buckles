#created dns record and setup weighted policy for traffic 

data "aws_route53_zone" "hosted-zone" {
  name = "mattpinizzotto.com"
}


resource "aws_route53_record" "blog-east" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "blog.mattpinizzotto.com"
  type    = "A"
  #ttl     = "60"

  alias {
    name                   = aws_elb.elb-east.dns_name
    zone_id                = aws_elb.elb-east.zone_id
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = 100
  }

  set_identifier = "blog-east"
  #records        = []
}


resource "aws_route53_record" "blog-west" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "blog.mattpinizzotto.com"
  type    = "A"
  #ttl = "60"
  alias {
    name                   = aws_elb.elb-west.dns_name
    zone_id                = aws_elb.elb-west.zone_id
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = 100
  }

  set_identifier = "blog-west"
  #records       = []
}




