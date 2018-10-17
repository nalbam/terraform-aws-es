// Output some useful variables for quick SSH access etc.

output "name" {
  value = "${lower(var.city)}-${lower(var.stage)}-${lower(var.name)}"
}

output "endpoint" {
  value = "${aws_elasticsearch_domain.default.*.endpoint}"
}

output "domain" {
  value = "${aws_route53_record.default.*.name}"
}
