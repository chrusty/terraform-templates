# VPC endpoint for S3:
resource "aws_vpc_endpoint" "private-s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.eu-west-1.s3"

  route_table_ids = [
    "${aws_route_table.admin-az-0.id}",
    "${aws_route_table.admin-az-1.id}",
    "${aws_route_table.admin-az-2.id}",
    "${aws_route_table.dmz-az-0.id}",
    "${aws_route_table.dmz-az-1.id}",
    "${aws_route_table.dmz-az-2.id}",
    "${aws_route_table.app1-az-0.id}",
    "${aws_route_table.app1-az-1.id}",
    "${aws_route_table.app1-az-2.id}",
    "${aws_route_table.data1-az-0.id}",
    "${aws_route_table.data1-az-1.id}",
    "${aws_route_table.data1-az-2.id}",
  ]
}
