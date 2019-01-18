// Output some useful variables for quick SSH access etc.

output "name" {
  value = "${local.name}"
}

output "endpoint" {
  value = "${element(concat(aws_elasticsearch_domain.default.*.endpoint, list("")), 0)}"
}

output "domain" {
  value = "${element(concat(aws_route53_record.default.*.name, list("")), 0)}"
}

output "snapshot_bucket" {
  value = "${element(concat(aws_s3_bucket.snapshot.*.bucket, list("")), 0)}"
}

output "snapshot_role_arn" {
  value = "${element(concat(aws_iam_role.snapshot_role.*.arn, list("")), 0)}"
}
