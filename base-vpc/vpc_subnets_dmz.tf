# dmz subnet in az-0:
resource "aws_subnet" "dmz-az-0" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.dmz, 2, 0)}"
  availability_zone = "${var.azs[0]}"

  tags {
    Name              = "dmz.${var.azs[0]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    KubernetesCluster = "k8s.${var.dns["domain_name"]}"
  }
}

# dmz subnet in az-1:
resource "aws_subnet" "dmz-az-1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.dmz, 2, 1)}"
  availability_zone = "${var.azs[1]}"

  tags {
    Name              = "dmz.${var.azs[1]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    KubernetesCluster = "k8s.${var.dns["domain_name"]}"
  }
}

# dmz subnet in az-2:
resource "aws_subnet" "dmz-az-2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(null_resource.security_layer_cidrs.triggers.dmz, 2, 2)}"
  availability_zone = "${var.azs[2]}"

  tags {
    Name              = "dmz.${var.azs[2]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    KubernetesCluster = "k8s.${var.dns["domain_name"]}"
  }
}

# Subnet-level ACL:
resource "aws_network_acl" "dmz" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.dmz-az-0.id}", "${aws_subnet.dmz-az-1.id}", "${aws_subnet.dmz-az-2.id}"]

  # Allow all ingress traffic from anywhere:
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
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
    Name = "dmz.${var.region}.i.${var.dns["domain_name"]}"
  }
}

# Outputs:
output "aws_subnets_dmz" {
  value = [
    "${aws_subnet.dmz-az-0.id}",
    "${aws_subnet.dmz-az-1.id}",
    "${aws_subnet.dmz-az-2.id}",
  ]
}
