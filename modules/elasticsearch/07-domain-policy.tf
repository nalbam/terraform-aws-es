data "aws_iam_user" "default" {
  count = "${var.domain_policy_enabled == "true" ? 1 : 0}"

  user_name = "${var.name}"
}

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
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  count = "${var.domain_policy_enabled == "true" ? 1 : 0}"

  domain_name     = "${var.name}"
  access_policies = "${join("", data.aws_iam_policy_document.default.*.json)}"
}
