data "aws_iam_policy_document" "default" {
  statement {
    actions = ["${distinct(compact(var.iam_actions))}"]

    resources = [
      "${join("", aws_elasticsearch_domain.default.*.arn)}",
      "${join("", aws_elasticsearch_domain.default.*.arn)}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${distinct(compact(var.iam_role_arns))}"]
    }
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  domain_name     = "${var.name}"
  access_policies = "${join("", data.aws_iam_policy_document.default.*.json)}"
}
