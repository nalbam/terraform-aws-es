resource "aws_elasticsearch_domain" "default" {
  domain_name = "${lower(local.simple_name)}"

  elasticsearch_version = "${var.elasticsearch_version}"

  advanced_options = "${var.advanced_options}"

  cluster_config {
    instance_count           = "${var.instance_count}"
    instance_type            = "${var.instance_type}"
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_count   = "${var.dedicated_master_count}"
    dedicated_master_type    = "${var.dedicated_master_type}"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }

  encrypt_at_rest {
    enabled    = "${var.encrypt_at_rest_enabled}"
    kms_key_id = "${var.encrypt_at_rest_kms_key_id}"
  }

  # vpc_options {
  #   // You must specify exactly one subnet.
  #   subnet_ids = ["${element(aws_subnet.default.*.id, 0)}"]

  #   security_group_ids = [
  #     "${aws_security_group.vpc.id}",
  #     "${aws_security_group.ingress.id}",
  #     "${aws_security_group.egress.id}",
  #   ]
  # }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_index_enabled}"
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_index_cloudwatch_log_group_arn}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_search_enabled}"
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_search_cloudwatch_log_group_arn}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_application_enabled}"
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = "${var.log_publishing_application_cloudwatch_log_group_arn}"
  }

  tags = {
    Name = "${local.full_name}"
  }

  # depends_on = ["aws_iam_service_linked_role.default"]
}
