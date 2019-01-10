// Output some useful variables for quick SSH access etc.

output "name" {
  value = "${local.full_name}"
}

output "endpoint" {
  value = "${element(concat(aws_elasticsearch_domain.default.*.endpoint, list("")), 0)}"
}

output "domain" {
  value = "${element(concat(aws_route53_record.default.*.name, list("")), 0)}"
}
