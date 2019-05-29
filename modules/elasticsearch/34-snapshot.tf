resource "aws_s3_bucket" "snapshot" {
  count  = var.snapshot_bucket_enabled == "true" ? 1 : 0
  bucket = "${local.lower_name}-snapshot"
  acl    = "private"

  tags = {
    Name = local.lower_name
  }
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "aws:kms"
  #     }
  #   }
  # }
}

