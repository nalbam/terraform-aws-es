resource "aws_security_group" "vpc" {
  name        = "${var.name}-es-vpc"
  description = "Default security group that allows all instances in the VPC."
  vpc_id      = "${data.aws_vpc.es.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name = "${var.name}-es-vpc"
  }
}

resource "aws_security_group" "egress" {
  name        = "${var.name}-es-egress"
  description = "Security group that allows egress."
  vpc_id      = "${data.aws_vpc.es.id}"

  // ALL
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-es-egress"
  }
}

resource "aws_security_group" "ingress" {
  name        = "${var.name}-es-ingress"
  description = "Security group that allows ingress."
  vpc_id      = "${data.aws_vpc.es.id}"

  // ALL
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-es-ingress"
  }
}
