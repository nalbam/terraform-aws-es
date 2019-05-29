data "aws_iam_policy_document" "domain_policy" {
  count = var.domain_policy_enabled == "true" ? 1 : 0

  statement {
    actions = var.iam_actions // ["es:*"]

    resources = [
      join("", aws_elasticsearch_domain.this.*.arn),
      "${join("", aws_elasticsearch_domain.this.*.arn)}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = var.iam_role_arns // ["*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.allow_ip_address
    }
  }
}

resource "aws_elasticsearch_domain_policy" "domain_policy" {
  count = var.domain_policy_enabled == "true" ? 1 : 0

  domain_name = aws_elasticsearch_domain.this.domain_name

  access_policies = join("", data.aws_iam_policy_document.domain_policy.*.json)
}

