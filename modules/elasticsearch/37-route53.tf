data "aws_route53_zone" "default" {
  count = "${var.base_domain != "" ? 1 : 0}"
  name  = "${var.base_domain}"
}

resource "aws_route53_record" "default" {
  count   = "${var.base_domain != "" ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.default.zone_id}"
  name    = "${local.global_name}.${data.aws_route53_zone.default.name}"
  type    = "CNAME"
  ttl     = 300
  records = [
    "${aws_elasticsearch_domain.default.*.endpoint}"
  ]
}
