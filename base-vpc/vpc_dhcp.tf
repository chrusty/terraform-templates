# DHCP options:
resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${var.region}.i.${var.dns["domain_name"]} i.${var.dns["domain_name"]} ${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name        = "${var.region}.i.${var.dns["domain_name"]}"
    environment = "${var.environment_name}"
  }
}

# Associate DHCP options to the VPC:
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}
