locals {
  metadata = {
    package = "terraform-aws-ipam"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  max_entries = coalesce(var.max_entries, length(var.entries))
}


###################################################
# Prefix List
###################################################

resource "aws_ec2_managed_prefix_list" "this" {
  region = var.region

  name           = var.name
  address_family = var.address_family
  max_entries    = local.max_entries

  dynamic "entry" {
    for_each = var.exclusive_entry_management_enabled ? var.entries : []

    content {
      cidr        = entry.value.cidr
      description = entry.value.description
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Entries of Prefix List
###################################################

resource "aws_ec2_managed_prefix_list_entry" "this" {
  for_each = {
    for entry in(var.exclusive_entry_management_enabled ? [] : var.entries) :
    entry.cidr => entry
  }

  region = var.region

  prefix_list_id = aws_ec2_managed_prefix_list.this.id

  cidr        = each.key
  description = each.value.description
}
