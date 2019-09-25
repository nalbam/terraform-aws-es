# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-demo-es"
}

variable "base_domain" {
  default = "nalbam.com"
}

variable "elasticsearch_version" {
  default = "6.3"
}

variable "instance_count" {
  default = 1
}

variable "instance_type" {
  default = "t2.small.elasticsearch"
}

variable "advanced_options" {
  default = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}

variable "dedicated_master_enabled" {
  default = "false"
}

variable "dedicated_master_count" {
  default = 1
}

variable "dedicated_master_type" {
  default = "m4.large.elasticsearch"
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_volume_size" {
  default = 32
}

variable "zone_awareness_enabled" {
  default = "false"
}

variable "encrypt_at_rest_enabled" {
  default = "false"
}

variable "domain_policy_enabled" {
  default = "true"
}

variable "snapshot_bucket_enabled" {
  default = "true"
}

variable "allow_ip_address" {
  default = [
    "58.151.93.9/32", // 강남
  ]
}

variable "tags" {
  default = {
    "KubernetesCluster" = "seoul-dev-demo-eks"
  }
}
