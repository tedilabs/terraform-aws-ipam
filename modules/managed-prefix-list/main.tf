locals {
  metadata = {
    package = "terraform-aws-ipam"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  }
}

data "aws_region" "this" {
  region = var.region
}


###################################################
# Managed Prefix List
###################################################

data "aws_ec2_managed_prefix_list" "this" {
  region = data.aws_region.this.region

  name = var.name
}

resource "aws_ec2_tag" "this" {
  for_each = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  region = data.aws_region.this.region

  resource_id = data.aws_ec2_managed_prefix_list.this.id
  key         = each.key
  value       = each.value
}
