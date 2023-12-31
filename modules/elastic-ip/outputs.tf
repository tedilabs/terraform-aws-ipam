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

output "scope" {
  description = "The scope of the Elastic IP address."
  value       = upper(aws_eip.this.domain)
}

output "network_border_group" {
  description = "The name of the network border group."
  value       = aws_eip.this.network_border_group
}

output "public_ip" {
  description = "The Elastic IP address."
  value       = aws_eip.this.public_ip
}
