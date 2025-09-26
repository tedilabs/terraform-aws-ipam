output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_eip.this.region
}

output "id" {
  description = "The ID of the Elastic IP."
  value       = aws_eip.this.id
}

output "allocation_id" {
  description = "The allocation ID of the Elastic IP."
  value       = aws_eip.this.allocation_id
}

output "name" {
  description = "The name of the Elastic IP."
  value       = var.name
}

output "type" {
  description = "The type of the Elastic IP address."
  value       = var.type
}

output "pool" {
  description = "The pool configuration of the Elastic IP address for `BYOIP`, `IPAM_POOL` or `OUTPOST` types."
  value = {
    id = (var.type == "BYOIP"
      ? aws_eip.this.public_ipv4_pool
      : (var.type == "IPAM_POOL"
        ? aws_eip.this.ipam_pool_id
        : (var.type == "OUTPOST"
          ? aws_eip.this.customer_owned_ipv4_pool
          : null
        )
      )
    )
    address = aws_eip.this.address
  }
}

output "network_border_group" {
  description = "The name of the network border group."
  value       = aws_eip.this.network_border_group
}

output "private_domain" {
  description = "The private domain associated with the Elastic IP address."
  value       = aws_eip.this.private_dns
}

output "private_ip" {
  description = "The Private IP address."
  value       = aws_eip.this.private_ip
}

output "public_domain" {
  description = "The public domain associated with the Elastic IP address."
  value       = aws_eip.this.public_dns
}

output "public_ip" {
  description = "The Elastic IP address."
  value       = aws_eip.this.public_ip
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
