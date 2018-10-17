// Define the VPC.
resource "aws_vpc" "default" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
  }
}

data "aws_vpc" "default" {
  id = "${var.vpc_id == "" ? element(concat(aws_vpc.default.*.id, list("")), 0) : var.vpc_id}"
}

// Create a Subnet.
resource "aws_subnet" "default" {
  count = "${length(data.aws_availability_zones.azs.names)}"

  vpc_id = "${data.aws_vpc.default.id}"

  cidr_block = "${cidrsubnet(data.aws_vpc.default.cidr_block, 8, 85 + count.index)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1))}-${var.stage}-${var.name}-${var.suffix}"
  }
}

// Create an Internet Gateway.
resource "aws_internet_gateway" "default" {
  vpc_id = "${data.aws_vpc.default.id}"

  tags = {
    Name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
  }
}

// Create a route table allowing.
resource "aws_route_table" "default" {
  vpc_id = "${data.aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags = {
    Name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
  }
}

// Now associate the route table with the default subnet
// - giving all default subnet instances access to the internet.
resource "aws_route_table_association" "default" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id = "${element(aws_subnet.default.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}
