provider "aws" {
  region = "us-east-1"
}


###################################################
# Managed Prefix List
###################################################

locals {
  managed_prefix_lists = [
    "com.amazonaws.global.groundstation",
    "com.amazonaws.global.cloudfront.origin-facing",
    "com.amazonaws.global.ipv6.cloudfront.origin-facing",
    "com.amazonaws.ap-northeast-1.dynamodb",
    "com.amazonaws.ap-northeast-1.ec2-instance-connect",
    "com.amazonaws.ap-northeast-1.ipv6.ec2-instance-connect",
    "com.amazonaws.ap-northeast-1.route53-healthchecks",
    "com.amazonaws.ap-northeast-1.ipv6.route53-healthchecks",
    "com.amazonaws.ap-northeast-1.s3",
    "com.amazonaws.ap-northeast-1.s3express",
    "com.amazonaws.ap-northeast-1.vpc-lattice",
    "com.amazonaws.ap-northeast-1.ipv6.vpc-lattice",
  ]
}

module "managed_prefix_list" {
  source = "../../modules/managed-prefix-list"
  # source  = "tedilabs/ipam/aws//modules/managed-prefix-list"
  # version = "~> 0.1.0"

  for_each = toset(local.managed_prefix_lists)

  name = each.key

  tags = {
    "project" = "terraform-aws-ipam-examples"
  }
}
