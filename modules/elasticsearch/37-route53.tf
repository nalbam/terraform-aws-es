data "aws_route53_zone" "this" {
  count = var.base_domain != "" ? 1 : 0
  name  = var.base_domain
}

resource "aws_route53_record" "this" {
  count   = var.base_domain != "" ? 1 : 0
  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = "${var.name}.${data.aws_route53_zone.this[0].name}"
  type    = "CNAME"
  ttl     = 300

  records = aws_elasticsearch_domain.this.*.endpoint
}
