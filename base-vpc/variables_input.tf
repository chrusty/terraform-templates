variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "dns" {
  default = {
    domain_name    = "domain.com"
    parent_zone_id = ""
  }
}

variable "environment_name" {
  default = "environment"
}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_network" {
  default = "10.0.0.0/16"
}
