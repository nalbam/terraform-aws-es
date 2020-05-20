# elasticsearch

resource "aws_elasticsearch_domain" "this" {
  domain_name = var.name

  elasticsearch_version = var.elasticsearch_version

  advanced_options = var.advanced_options

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    zone_awareness_enabled   = var.zone_awareness_enabled
  }

  # vpc_options {
  #   subnet_ids         = var.subnet_ids
  #   security_group_ids = var.security_group_ids
  # }

  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
    iops        = var.ebs_iops
  }

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest_enabled
    kms_key_id = var.encrypt_at_rest_kms_key_id
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  cognito_options {
    enabled          = var.cognito_authentication_enabled
    user_pool_id     = var.cognito_user_pool_id
    identity_pool_id = var.cognito_identity_pool_id
    role_arn         = var.cognito_iam_role_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_index_enabled
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_index_cloudwatch_log_group_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_search_enabled
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_search_cloudwatch_log_group_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_application_enabled
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_application_cloudwatch_log_group_arn
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )
  # depends_on = ["aws_iam_service_linked_role.this"]
}
