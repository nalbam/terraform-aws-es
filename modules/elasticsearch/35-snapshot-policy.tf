data "aws_iam_policy_document" "snapshot_role" {
  count = "${var.snapshot_bucket_enabled == "true" ? 1 : 0}"

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "snapshot_role" {
  count              = "${var.snapshot_bucket_enabled == "true" ? 1 : 0}"
  name               = "${local.full_name}-snapshot"
  description        = "Role used for the Elasticsearch domain"
  assume_role_policy = "${data.aws_iam_policy_document.snapshot_role.json}"
}

data "aws_iam_policy_document" "snapshot_policy" {
  count = "${var.snapshot_bucket_enabled == "true" ? 1 : 0}"

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "iam:PassRole",
    ]

    resources = [
      "${aws_s3_bucket.snapshot.arn}",
      "${aws_s3_bucket.snapshot.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "snapshot_policy" {
  count       = "${var.snapshot_bucket_enabled == "true" ? 1 : 0}"
  name        = "${local.full_name}-snapshot"
  description = "Policy allowing the Elasticsearch domain access to the snapshots S3 bucket"
  policy      = "${data.aws_iam_policy_document.snapshot_policy.json}"
}

resource "aws_iam_role_policy_attachment" "snapshot_policy_attachment" {
  count      = "${var.snapshot_bucket_enabled == "true" ? 1 : 0}"
  role       = "${aws_iam_role.snapshot_role.id}"
  policy_arn = "${aws_iam_policy.snapshot_policy.arn}"
}
