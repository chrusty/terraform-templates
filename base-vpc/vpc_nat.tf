# EIP for NAT-gateway in az-0:
resource "aws_eip" "nat-az-0" {
  vpc = true
}

# EIP for NAT-gateway in az-1:
resource "aws_eip" "nat-az-1" {
  vpc = true
}

# EIP for NAT-gateway in az-2:
resource "aws_eip" "nat-az-2" {
  vpc = true
}

# NAT-gateway in az-0:
resource "aws_nat_gateway" "az-0" {
  allocation_id = "${aws_eip.nat-az-0.id}"
  subnet_id     = "${aws_subnet.dmz-az-0.id}"
}

# NAT-gateway in az-1:
resource "aws_nat_gateway" "az-1" {
  allocation_id = "${aws_eip.nat-az-1.id}"
  subnet_id     = "${aws_subnet.dmz-az-1.id}"
}

# NAT-gateway in az-2:
resource "aws_nat_gateway" "az-2" {
  allocation_id = "${aws_eip.nat-az-2.id}"
  subnet_id     = "${aws_subnet.dmz-az-2.id}"
}

output "aws_nat_gateway_public_ips" {
  value = [
    "${aws_nat_gateway.az-0.public_ip}",
    "${aws_nat_gateway.az-1.public_ip}",
    "${aws_nat_gateway.az-2.public_ip}",
  ]
}
