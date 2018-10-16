# elasticsearch

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key = "elasticsearch.tfstate"
  }
  required_version = "> 0.11.0"
}

data "aws_iam_user" "dev" {
  user_name = "dev"
}

module "elasticsearch" {
  source      = "./modules/elasticsearch"
  region      = "${var.region}"
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  vpc_cidr    = "${var.vpc_cidr}"
  base_domain = "${var.base_domain}"

  instance_type  = "t2.small.elasticsearch"
  instance_count = 1

  ebs_volume_size = 10

  zone_awareness_enabled  = "false"
  encrypt_at_rest_enabled = "false"

  iam_role_arns = ["${data.aws_iam_user.dev.arn}"]
  iam_actions   = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}

output "domain" {
  value = "${module.elasticsearch.domain}"
}

output "kibana" {
  value = "${module.elasticsearch.kibana}"
}
