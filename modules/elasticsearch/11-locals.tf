# locals

locals {
  full_name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"

  upper_name = "${upper(local.full_name)}"

  lower_name = "${lower(local.full_name)}"

  az_count = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
}

data "aws_availability_zones" "azs" {}
