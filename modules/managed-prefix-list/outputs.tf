output "region" {
  description = "The AWS region this module resources resides in."
  value       = data.aws_ec2_managed_prefix_list.this.region
}

output "id" {
  description = "The ID of the prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.id
}

output "arn" {
  description = "The ARN of the prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.arn
}

output "owner" {
  description = "The ID of the AWS account that owns this prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.owner_id
}

output "name" {
  description = "The name of the prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.name
}

output "address_family" {
  description = "The address family of the prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.address_family
}

output "version" {
  description = "Latest version of this prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.version
}

output "max_entries" {
  description = "The maximum number of entries of this prefix list."
  value       = data.aws_ec2_managed_prefix_list.this.max_entries
}

output "entries" {
  description = "A set of prefix list entries."
  value       = data.aws_ec2_managed_prefix_list.this.entries
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
