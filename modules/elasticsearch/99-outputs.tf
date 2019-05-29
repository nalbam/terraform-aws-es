// Output some useful variables for quick SSH access etc.

output "name" {
  value = aws_elasticsearch_domain.this.domain_name
}

output "endpoint" {
  value = aws_elasticsearch_domain.this.endpoint
}

output "domain" {
  value = element(concat(aws_route53_record.this.*.name, [""]), 0)
}

output "snapshot_bucket" {
  value = element(concat(aws_s3_bucket.snapshot.*.bucket, [""]), 0)
}

output "snapshot_role_arn" {
  value = element(concat(aws_iam_role.snapshot_role.*.arn, [""]), 0)
}

