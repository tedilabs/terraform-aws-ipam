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

  tier = {
    "FREE"     = "free"
    "ADVANCED" = "advanced"
  }
  metered_account = {
    "IPAM_OWNER"     = "ipam-owner"
    "RESOURCE_OWNER" = "resource-owner"
  }
}


###################################################
# IPAM (IP Address Manager)
###################################################

resource "aws_vpc_ipam" "this" {
  region = local.region

  description = var.description
  cascade     = var.cascade_deletion_enabled

  tier            = local.tier[var.tier]
  metered_account = local.metered_account[var.metered_account]

  dynamic "operating_regions" {
    for_each = var.operating_regions
    iterator = region

    content {
      region_name = region.value
    }
  }

  enable_private_gua = var.private_gua_enabled

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    precondition {
      condition     = contains(var.operating_regions, local.region)
      error_message = "The current region must be included in `operating_regions`."
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


###################################################
# Scopes of IPAM (IP Address Manager)
###################################################

resource "aws_vpc_ipam_scope" "this" {
  for_each = {
    for scope in var.additional_private_scopes :
    scope.name => scope
  }

  region = local.region

  ipam_id     = aws_vpc_ipam.this.id
  description = each.value.description

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Associations of IPAM Resource Discoveries
###################################################

resource "aws_vpc_ipam_resource_discovery_association" "this" {
  count = length(var.additional_resource_discovery_associations)

  region = local.region

  ipam_id                    = aws_vpc_ipam.this.id
  ipam_resource_discovery_id = var.additional_resource_discovery_associations[count.index].resource_discovery

  tags = merge(
    {
      "Name" = var.additional_resource_discovery_associations[count.index].resource_discovery
    },
    local.module_tags,
    var.additional_resource_discovery_associations[count.index].tags,
  )
}
