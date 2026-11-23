variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the IPAM resource discovery."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description for the IPAM resource discovery."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "operating_regions" {
  description = <<EOF
  (Optional) A set of operating regions for the IPAM resource discovery. Operating Regions are AWS Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the AWS Regions you select as operating Regions. The current region is required to include.
  EOF
  type        = set(string)
  default     = []
  nullable    = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module information."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configuration of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}


###################################################
# Resource Sharing by RAM (Resource Access Manager)
###################################################

variable "shares" {
  description = <<EOF
  (Optional) A list of resource shares via RAM (Resource Access Manager). Each block of `shares` as defined below.
    (Required) `name` - The name of the resource share. The name of the RAM resource share is generated with the name of the IPAM resource discovery as a prefix.
    (Optional) `permissions` - A set of the names of the RAM permissions to associate with the resource share. Defaults to `["AWSRAMPermissionIpamResourceDiscovery"]`.
    (Optional) `external_principals_allowed` - Whether principals outside your organization can be associated with the resource share. Defaults to `false`.
    (Optional) `principals` - A set of principals to associate with the resource share. Possible values are an AWS account ID, an ARN of an organization in AWS Organizations, an ARN of an organizational unit (OU) in AWS Organizations, or an ARN of an IAM role or user. Defaults to `[]`.
    (Optional) `tags` - A map of tags to add to the resource share. Defaults to `{}`.
  EOF
  type = list(object({
    name = string

    permissions = optional(set(string), ["AWSRAMPermissionIpamResourceDiscovery"])

    external_principals_allowed = optional(bool, false)
    principals                  = optional(set(string), [])

    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
