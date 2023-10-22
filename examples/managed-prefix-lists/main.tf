provider "aws" {
  region = "us-east-1"
}


###################################################
# Managed Prefix List
###################################################

locals {
  managed_prefix_lists = [
    {
      service        = "dynamodb"
      address_family = "IPv4"
    },
    {
      service        = "s3"
      address_family = "IPv4"
    },
    {
      service        = "cloudfront.origin-facing"
      is_global      = true
      address_family = "IPv4"
    },
    {
      service        = "groundstation"
      is_global      = true
      address_family = "IPv4"
    },
    {
      service        = "route53-healthchecks"
      address_family = "IPv4"
    },
    {
      service        = "route53-healthchecks"
      address_family = "IPv6"
    },
    {
      service        = "vpc-lattice"
      address_family = "IPv4"
    },
    {
      service        = "vpc-lattice"
      address_family = "IPv6"
    },
  ]
}

module "managed_prefix_list" {
  source = "../../modules/managed-prefix-list"
  # source  = "tedilabs/ipam/aws//modules/managed-prefix-list"
  # version = "~> 0.1.0"

  for_each = {
    for prefix_list in local.managed_prefix_lists :
    "${prefix_list.service}/${lower(prefix_list.address_family)}" => prefix_list
  }

  service        = each.value.service
  is_global      = try(each.value.is_global, false)
  address_family = each.value.address_family
}
