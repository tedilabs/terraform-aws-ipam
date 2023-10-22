provider "aws" {
  region = "us-east-1"
}


###################################################
# Elastic IP
###################################################

module "eip" {
  source = "../../modules/elastic-ip"
  # source  = "tedilabs/ipam/aws//modules/elastic-ip"
  # version = "~> 0.2.0"

  name = "test-amazon"
  type = "AMAZON"

  tags = {
    "project" = "terraform-aws-ipam-examples"
  }
}
