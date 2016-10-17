# Derive subnet CIDRs:
resource "null_resource" "security_layer_cidrs" {
  triggers = {
    dmz   = "${cidrsubnet(var.vpc_network, 5, 0)}"
    app1  = "${cidrsubnet(var.vpc_network, 5, 1)}"
    data1 = "${cidrsubnet(var.vpc_network, 5, 2)}"
    admin = "${cidrsubnet(var.vpc_network, 5, 3)}"
  }
}

output "security_layer_cidrs" {
  value = {
    admin = "${null_resource.security_layer_cidrs.triggers.admin}"
    dmz   = "${null_resource.security_layer_cidrs.triggers.dmz}"
    app1  = "${null_resource.security_layer_cidrs.triggers.app1}"
    data1 = "${null_resource.security_layer_cidrs.triggers.data1}"
  }
}
