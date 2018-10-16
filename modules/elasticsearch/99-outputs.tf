// Output some useful variables for quick SSH access etc.

output "domain" {
  value = "${aws_route53_record.es.*.name}"
}

output "kibana" {
  value = "${aws_route53_record.kibana.*.name}"
}
