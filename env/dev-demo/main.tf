# bastion

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "elasticsearch.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "elasticsearch" {
  source = "../../modules/elasticsearch"

  region = "ap-northeast-2"
  name   = "seoul-dev-demo-es"

  base_domain = "nalbam.com"

  instance_count = 1
  instance_type  = "t2.small.elasticsearch"

  dedicated_master_enabled = "true"
  dedicated_master_count   = 3
  dedicated_master_type    = "m4.large.elasticsearch"

  ebs_volume_size = 64

  zone_awareness_enabled  = "false"
  encrypt_at_rest_enabled = "false"
  domain_policy_enabled   = "true"
  snapshot_bucket_enabled = "true"

  allow_ip_address = [
    "58.151.93.9/32", // 강남
  ]

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  tags = {
    "KubernetesCluster" = "seoul-dev-demo-eks"
  }
}

output "name" {
  value = module.elasticsearch.name
}

output "endpoint" {
  value = module.elasticsearch.endpoint
}

output "domain" {
  value = module.elasticsearch.domain
}

output "snapshot_bucket" {
  value = module.elasticsearch.snapshot_bucket
}

output "snapshot_role_arn" {
  value = module.elasticsearch.snapshot_role_arn
}
