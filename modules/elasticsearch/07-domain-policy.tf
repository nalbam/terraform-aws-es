data "aws_iam_policy_document" "default" {
  count = "${var.domain_policy_enabled == "true" ? 1 : 0}"

  statement {
    actions = ["${distinct(compact(var.iam_actions))}"]

    resources = [
      "${join("", aws_elasticsearch_domain.default.*.arn)}",
      "${join("", aws_elasticsearch_domain.default.*.arn)}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_iam_user.default.arn}"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["${distinct(compact(var.allow_ip_address))}"]
    }
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  count = "${var.domain_policy_enabled == "true" ? 1 : 0}"

  domain_name = "${lower(var.city)}-${lower(var.stage)}-${lower(var.name)}"

  access_policies = "${join("", data.aws_iam_policy_document.default.*.json)}"
}
