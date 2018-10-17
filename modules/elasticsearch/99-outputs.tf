// Output some useful variables for quick SSH access etc.

output "domain" {
  value = "${aws_route53_record.default.*.name}"
}
