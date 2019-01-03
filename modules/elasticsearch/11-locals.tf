# locals

locals {
  name  = "${var.stage}-${var.name}"

  simple_name  = "${var.city}-${local.name}"

  global_name  = "${local.name}-${var.suffix}"

  full_name  = "${local.simple_name}-${var.suffix}"

  az_count = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
}

data "aws_availability_zones" "azs" {}
