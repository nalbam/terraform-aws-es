data "aws_route53_zone" "main" {
  count = "${var.base_domain != "" ? 1 : 0}"
  name  = "${var.base_domain}"
}

resource "aws_route53_record" "es" {
  count   = "${var.base_domain != "" ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${var.name}-es.${data.aws_route53_zone.main.name}"
  type    = "CNAME"
  ttl     = 300
  records = [
    "${aws_elasticsearch_domain.default.*.endpoint}"
  ]
}

# resource "aws_route53_record" "kibana" {
#   count   = "${var.base_domain != "" ? 1 : 0}"
#   zone_id = "${data.aws_route53_zone.main.zone_id}"
#   name    = "${var.name}-kibana.${data.aws_route53_zone.main.name}"
#   type    = "CNAME"
#   ttl     = 300
#   records = [
#     "${aws_elasticsearch_domain.default.*.kibana_endpoint}"
#   ]
# }
