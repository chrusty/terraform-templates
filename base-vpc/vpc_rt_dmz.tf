# Route-table (dmz subnet in az-0):
resource "aws_route_table" "dmz-az-0" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name              = "dmz.${var.azs[0]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[0]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "dmz-az-0" {
  subnet_id      = "${aws_subnet.dmz-az-0.id}"
  route_table_id = "${aws_route_table.dmz-az-0.id}"
}

# Route-table (dmz subnet in az-1):
resource "aws_route_table" "dmz-az-1" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name              = "dmz.${var.azs[1]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[1]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "dmz-az-1" {
  subnet_id      = "${aws_subnet.dmz-az-1.id}"
  route_table_id = "${aws_route_table.dmz-az-1.id}"
}

# Route-table (dmz subnet in az-2):
resource "aws_route_table" "dmz-az-2" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name              = "dmz.${var.azs[2]}.i.${var.dns["domain_name"]}"
    role              = "dmz"
    environment       = "${var.environment_name}"
    availability_zone = "${var.azs[2]}"
  }
}

# Associate the route-table:
resource "aws_route_table_association" "dmz-az-2" {
  subnet_id      = "${aws_subnet.dmz-az-2.id}"
  route_table_id = "${aws_route_table.dmz-az-2.id}"
}
