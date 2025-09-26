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


###################################################
# Elastic IP
###################################################

# INFO: Not supported attributes
# - `associate_with_private_ip`
# - `instance`
# - `network_interface`
resource "aws_eip" "this" {
  region = var.region

  domain = "vpc"

  network_border_group = (var.type == "AMAZON"
    ? var.network_border_group
    : null
  )
  public_ipv4_pool = (var.type == "BYOIP"
    ? var.pool.id
    : (var.type == "AMAZON"
      ? "amazon"
      : null
    )
  )
  ipam_pool_id = (var.type == "IPAM_POOL"
    ? var.pool.id
    : null
  )
  customer_owned_ipv4_pool = (var.type == "OUTPOST"
    ? var.pool.id
    : null
  )
  address = (var.type != "AMAZON"
    ? var.pool.address
    : null
  )

  timeouts {
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  lifecycle {
    ignore_changes = [
      associate_with_private_ip,
      instance,
      network_interface,
    ]
  }
}
