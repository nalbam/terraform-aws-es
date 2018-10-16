// Define the VPC.
resource "aws_vpc" "es" {
  count = "${var.vpc_id == "" ? 1 : 0}"

  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-es"
  }
}

data "aws_vpc" "es" {
  id = "${var.vpc_id == "" ? aws_vpc.es.id : var.vpc_id}"
}

// Create a Subnet.
resource "aws_subnet" "es" {
  count = "${length(data.aws_availability_zones.azs.names)}"

  vpc_id = "${data.aws_vpc.es.id}"

  cidr_block = "${cidrsubnet(data.aws_vpc.es.cidr_block, 8, 31 + count.index)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-es-${element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1)}"
  }
}

// Create an Internet Gateway.
resource "aws_internet_gateway" "es" {
  vpc_id = "${data.aws_vpc.es.id}"

  tags = {
    Name = "${var.name}-es"
  }
}

// Create a route table allowing all addresses access.
resource "aws_route_table" "es" {
  vpc_id = "${data.aws_vpc.es.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.es.id}"
  }

  tags = {
    Name = "${var.name}-es"
  }
}

// Now associate the route table with the es subnet
// - giving all es subnet instances access to the internet.
resource "aws_route_table_association" "es" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id = "${element(aws_subnet.es.*.id, count.index)}"
  route_table_id = "${aws_route_table.es.id}"
}
