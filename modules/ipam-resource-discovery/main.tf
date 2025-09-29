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

data "aws_region" "this" {
  region = var.region
}

data "aws_regions" "this" {
  all_regions = true

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required", "opted-in"]
  }
}

locals {
  region      = data.aws_region.this.region
  all_regions = data.aws_regions.this.names
}


###################################################
# Resource Discovery of IPAM (IP Address Manager)
###################################################

resource "aws_vpc_ipam_resource_discovery" "this" {
  region = local.region

  description = var.description

  dynamic "operating_regions" {
    for_each = var.operating_regions
    iterator = region

    content {
      region_name = region.value
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    precondition {
      condition     = contains(var.operating_regions, var.region)
      error_message = "The current region is required to include in `operating_regions`."
    }

    precondition {
      condition = alltrue([
        for region in var.operating_regions :
        contains(local.all_regions, region)
      ])
      error_message = "There is invalid AWS region name."
    }
  }
}
