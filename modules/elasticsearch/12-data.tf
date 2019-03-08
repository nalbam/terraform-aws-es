# data

data "aws_availability_zones" "azs" {}

data "aws_caller_identity" "current" {}

data "template_file" "register_repo" {
  template = "${file("${path.module}/template/register_repo.py")}"

  vars {
    AWS_USERID = "${data.aws_caller_identity.current.account_id}"
    AWS_BUCKET = "${local.lower_name}-snapshot"
    AWS_REGION = "${var.region}"
    ES_HOST    = "https://${aws_elasticsearch_domain.this.endpoint}/"
  }
}
