locals {
  metadata = {
    package = "terraform-aws-ipam"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = "${var.service}/${var.address_family}"
  }
  module_tags = {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  }
}

data "aws_region" "this" {}

locals {
  region = data.aws_region.this.name
  prefix_list_name = join(".", compact([
    "com",
    "amazonaws",
    var.is_global ? "global" : local.region,
    var.address_family == "IPv6" ? "ipv6" : "",
    var.service
  ]))
}


###################################################
# Managed Prefix List
###################################################

data "aws_ec2_managed_prefix_list" "this" {
  name = local.prefix_list_name
}
