# Route-table (admin subnet in az-0):
resource "aws_route_table" "admin-az-0" {
  vpc_id = "${aws_vpc.main.id}"

  lifecycle {
    ignore_changes = ["route", "propagating_vgws"]
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.az-0.id}"
  }

  tags {
    Name              = "admin.${var.azs[0]}.i.${var.dns["domain_name"]}"
    role              = "admin"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[0]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "admin-az-0" {
  subnet_id      = "${aws_subnet.admin-az-0.id}"
  route_table_id = "${aws_route_table.admin-az-0.id}"
}

# Route-table (admin subnet in az-1):
resource "aws_route_table" "admin-az-1" {
  vpc_id = "${aws_vpc.main.id}"

  lifecycle {
    ignore_changes = ["route", "propagating_vgws"]
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.az-1.id}"
  }

  tags {
    Name              = "admin.${var.azs[1]}.i.${var.dns["domain_name"]}"
    role              = "admin"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[1]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "admin-az-1" {
  subnet_id      = "${aws_subnet.admin-az-1.id}"
  route_table_id = "${aws_route_table.admin-az-1.id}"
}

# Route-table (admin subnet in az-2):
resource "aws_route_table" "admin-az-2" {
  vpc_id = "${aws_vpc.main.id}"

  lifecycle {
    ignore_changes = ["route", "propagating_vgws"]
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.az-2.id}"
  }

  tags {
    Name              = "admin.${var.azs[2]}.i.${var.dns["domain_name"]}"
    role              = "admin"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[2]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "admin-az-2" {
  subnet_id      = "${aws_subnet.admin-az-2.id}"
  route_table_id = "${aws_route_table.admin-az-2.id}"
}
