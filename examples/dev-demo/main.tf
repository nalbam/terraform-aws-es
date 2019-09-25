# elasticsearch

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "elasticsearch.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "elasticsearch" {
  source = "../../"

  region = var.region
  name   = var.name

  base_domain = var.base_domain

  instance_count = var.instance_count
  instance_type  = var.instance_type

  advanced_options = var.advanced_options

  dedicated_master_enabled = var.dedicated_master_enabled
  dedicated_master_count   = var.dedicated_master_count
  dedicated_master_type    = var.dedicated_master_type

  ebs_volume_type = var.ebs_volume_type
  ebs_volume_size = var.ebs_volume_size

  zone_awareness_enabled  = var.zone_awareness_enabled
  encrypt_at_rest_enabled = var.encrypt_at_rest_enabled
  domain_policy_enabled   = var.domain_policy_enabled
  snapshot_bucket_enabled = var.snapshot_bucket_enabled

  allow_ip_address = var.allow_ip_address

  tags = var.tags
}
