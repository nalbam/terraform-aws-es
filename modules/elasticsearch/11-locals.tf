# locals

locals {
  full_name = "${var.stage}-${var.name}"

  upper_name = "${upper(local.full_name)}"

  lower_name = "${lower(local.full_name)}"

  # sub_domain = "${lower(var.stage)}-${lower(var.name)}-${lower(var.suffix)}"

  # az_count = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
}
