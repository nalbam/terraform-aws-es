variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: demo"
}

variable "vpc_id" {
  description = "The VPC ID."
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default = "10.0.0.0/16"
}

variable "base_domain" {
  description = "Base domain of the elasticsearch, e.g: nalbam.com"
  default = ""
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options"
  type        = "map"
  default     = {}
}

variable "elasticsearch_version" {
  description = "Version of Elasticsearch to deploy"
  type        = "string"
  default     = "6.3"
}

variable "instance_type" {
  description = "Elasticsearch instance type for data nodes in the cluster"
  type        = "string"
  default     = "t2.small.elasticsearch"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster"
  default     = 1
}

variable "iam_role_arns" {
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
  type        = "list"
  default     = []
}

variable "iam_actions" {
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
  type        = "list"
  default     = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]
}

variable "zone_awareness_enabled" {
  // You must select an even number of data nodes if zone awareness is enabled.
  description = "Enable zone awareness for Elasticsearch cluster"
  type        = "string"
  default     = "false"
}

variable "ebs_volume_size" {
  description = "Optionally use EBS volumes for data storage by specifying volume size in GB"
  default     = 0
}

variable "ebs_volume_type" {
  description = "Storage type of EBS volumes"
  type        = "string"
  default     = "gp2"
}

variable "ebs_iops" {
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
  default     = 0
}

variable "encrypt_at_rest_enabled" {
  // Encryption at rest is not supported with t2.small.elasticsearch instances
  description = "Whether to enable encryption at rest"
  type        = "string"
  default     = "false"
}

variable "encrypt_at_rest_kms_key_id" {
  description = "The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
  type        = "string"
  default     = ""
}

variable "log_publishing_index_enabled" {
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
  type        = "string"
  default     = "false"
}

variable "log_publishing_search_enabled" {
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
  type        = "string"
  default     = "false"
}

variable "log_publishing_application_enabled" {
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
  type        = "string"
  default     = "false"
}

variable "log_publishing_index_cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
  type        = "string"
  default     = ""
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS  needs to be published"
  type        = "string"
  default     = ""
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
  type        = "string"
  default     = ""
}

variable "automated_snapshot_start_hour" {
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}

variable "dedicated_master_enabled" {
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
  type        = "string"
  default     = "false"
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  description = "Instance type of the dedicated master nodes in the cluster"
  type        = "string"
  default     = "t2.small.elasticsearch"
}

data "aws_availability_zones" "azs" {}
