# app1 subnet in az-0:
resource "aws_subnet" "app1-az-0" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.app1, 2, 0)}"
  availability_zone = "${var.azs[0]}"

  tags {
    Name        = "app1.${var.azs[0]}.i.${var.dns["domain_name"]}"
    role        = "app1"
    environment = "${var.environment_name}"
  }
}

# app1 subnet in az-1:
resource "aws_subnet" "app1-az-1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.app1, 2, 1)}"
  availability_zone = "${var.azs[1]}"

  tags {
    Name        = "app1.${var.azs[1]}.i.${var.dns["domain_name"]}"
    role        = "app1"
    environment = "${var.environment_name}"
  }
}

# app1 subnet in az-2:
resource "aws_subnet" "app1-az-2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.app1, 2, 2)}"
  availability_zone = "${var.azs[2]}"

  tags {
    Name        = "app1.${var.azs[2]}.i.${var.dns["domain_name"]}"
    role        = "app1"
    environment = "${var.environment_name}"
  }
}

# Subnet-level ACL:
resource "aws_network_acl" "app1" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.app1-az-0.id}", "${aws_subnet.app1-az-1.id}", "${aws_subnet.app1-az-2.id}"]

  # Allow cross-AZ traffic within this layer:
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${null_resource.security_layer_cidrs.triggers.app1}"
    from_port  = 0
    to_port    = 0
  }

  # Allow all ingress traffic from the DMZ layer:
  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${null_resource.security_layer_cidrs.triggers.dmz}"
    from_port  = 0
    to_port    = 0
  }

  # Allow all traffic from the ADMIN layer:
  ingress {
    protocol   = "-1"
    rule_no    = 210
    action     = "allow"
    cidr_block = "${null_resource.security_layer_cidrs.triggers.admin}"
    from_port  = 0
    to_port    = 0
  }

  # Allow return packets to the ephemeral port-range:
  ingress {
    protocol   = "TCP"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32768
    to_port    = 65535
  }

  # Allow return packets to the ephemeral port-range:
  ingress {
    protocol   = "UDP"
    rule_no    = 310
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32768
    to_port    = 65535
  }

  # Allow ICMP:
  ingress {
    protocol   = "ICMP"
    rule_no    = 320
    action     = "allow"
    cidr_block = "${aws_vpc.main.cidr_block}"
    icmp_type  = -1
    icmp_code  = -1
    from_port  = 0
    to_port    = 0
  }

  # Allow all egress traffic:
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "app1.${var.region}.i.${var.dns["domain_name"]}"
  }
}

# Outputs:
output "aws_subnets_app1" {
  value = [
    "${aws_subnet.app1-az-0.id}",
    "${aws_subnet.app1-az-1.id}",
    "${aws_subnet.app1-az-2.id}",
  ]
}
