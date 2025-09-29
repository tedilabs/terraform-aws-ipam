variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the IPAM."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description for the IPAM."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "cascade_deletion_enabled" {
  description = "(Optional) Whether to enable you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "tier" {
  description = "(Optional) The tier of the IPAM. Valid values are `FREE` and `ADVANCED`. Defaults to `FREE`."
  type        = string
  default     = "FREE"
  nullable    = false

  validation {
    condition     = contains(["FREE", "ADVANCED"], var.tier)
    error_message = "The tier must be either 'FREE' or 'ADVANCED'."
  }
}

variable "metered_account" {
  description = "(Optional) The AWS account that is charged for active IP addresses managed in IPAM. Valid values are `IPAM_OWNER` and `RESOURCE_OWNER`. Defaults to `ipam-owner`."
  type        = string
  default     = "IPAM_OWNER"
  nullable    = false

  validation {
    condition     = contains(["IPAM_OWNER", "RESOURCE_OWNER"], var.metered_account)
    error_message = "The metered_account must be either 'IPAM_OWNER' or 'RESOURCE_OWNER'."
  }
}

variable "operating_regions" {
  description = <<EOF
  (Optional) A set of operating regions for the IPAM. Operating Regions are AWS Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only discovers and monitors resources in the AWS Regions you select as operating Regions. The current region is required to include.
  EOF
  type        = set(string)
  default     = []
  nullable    = false
}

variable "private_gua_enabled" {
  description = "(Optional) Whether to use your own private GUA address space as private IPv6 addresses. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_private_scopes" {
  description = <<EOF
  (Optional) A list of additional scopes to create and manage by the IPAM. A scope is the highest-level container within IPAM. When you create an IPAM, IPAM creates two default scopes for you. Each scope represents the IP space for a single network. Each block of `additional_scopes` as defined below.
    (Required) `name` - A name of the scope in the IPAM.
    (Optional) `description` - A description of the scope in the IPAM.
  EOF
  type = list(object({
    name        = string
    description = optional(string, "Managed by Terraform.")
  }))
  default  = []
  nullable = false
}

variable "additional_resource_discovery_associations" {
  description = <<EOF
  (Optional) A list of additional associations to an IPAM resource discovery with an Amazon VPC IPAM. A resource discovery is an IPAM component that enables IPAM to manage and monitor resources that belong to the owning account. Each block of `additional_resource_discovery_associations` as defined below.
    (Required) `resource_discovery` - The ID of the Resource Discovery to associate.
    (Optional) `tags` - A map of tags to add to the IPAM resource discovery association resource.
  EOF
  type = list(object({
    resource_discovery = string
    tags               = optional(map(string), {})
  }))
  default  = []
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
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
