# locals

locals {
  name = "${lower(var.stage)}-${lower(var.name)}"

  simple_name = "${lower(var.city)}-${local.name}"

  global_name = "${local.name}-${lower(var.suffix)}"

  full_name = "${local.simple_name}-${lower(var.suffix)}"

  az_count = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
}

data "aws_availability_zones" "azs" {}
