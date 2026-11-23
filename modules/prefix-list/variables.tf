variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the prefix list. The name must not start with `com.amazonaws`."
  type        = string
  nullable    = false

  validation {
    condition     = !startswith(var.name, "com.amazonaws")
    error_message = "The name must not start with `com.amazonaws`."
  }
}

variable "address_family" {
  description = "(Required) Address family of this prefix list. Valid values are `IPv4` or `IPv6`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["IPv4", "IPv6"], var.address_family)
    error_message = "Valid values for `address_family` are `IPv4` or `IPv6`."
  }
}

variable "max_entries" {
  description = "(Optional) Maximum number of entries that this prefix list can contain. Configured the length of `entries` if not provided."
  type        = number
  default     = null
  nullable    = true

  validation {
    condition     = var.max_entries == null || var.max_entries >= 1
    error_message = "`max_entries` must be at least 1."
  }
  validation {
    condition     = var.max_entries != null || length(var.entries) > 0
    error_message = "`max_entries` is required when `entries` is empty."
  }
}

variable "exclusive_entry_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for entries of the prefix list. This includes removal of entries which are not explicitly configured. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "entries" {
  description = <<EOF
  (Optional) A set of prefix list entries. Each block of `entries` as defined below.
    (Required) `cidr` - The CIDR block of this entry.
    (Optional) `description` - The description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry.
  EOF
  type = set(object({
    cidr        = string
    description = optional(string, "Managed by Terraform.")
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
    (Required) `name` - The name of the resource share. The name of the RAM resource share is generated with the name of the prefix list as a prefix.
    (Optional) `permissions` - A set of the names of the RAM permissions to associate with the resource share. Defaults to `["AWSRAMDefaultPermissionPrefixList"]`.
    (Optional) `external_principals_allowed` - Whether principals outside your organization can be associated with the resource share. Defaults to `false`.
    (Optional) `principals` - A set of principals to associate with the resource share. Possible values are an AWS account ID, an ARN of an organization in AWS Organizations, an ARN of an organizational unit (OU) in AWS Organizations, or an ARN of an IAM role or user. Defaults to `[]`.
    (Optional) `tags` - A map of tags to add to the resource share. Defaults to `{}`.
  EOF
  type = list(object({
    name = string

    permissions = optional(set(string), ["AWSRAMDefaultPermissionPrefixList"])

    external_principals_allowed = optional(bool, false)
    principals                  = optional(set(string), [])

    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
