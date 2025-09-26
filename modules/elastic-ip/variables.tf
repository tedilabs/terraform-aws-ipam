variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name of the Elastic IP."
  type        = string
  nullable    = false
}

variable "type" {
  description = <<EOF
  (Optional) The type of the Elastic IP to decide how to allocate. Valid values are `AMAZON`, `BYOIP`, `IPAM_POOL` and `OUTPOST`. Defaults to `AMAZON`.
  EOF
  type        = string
  default     = "AMAZON"
  nullable    = false

  validation {
    condition     = contains(["AMAZON", "BYOIP", "IPAM_POOL", "OUTPOST"], var.type)
    error_message = "Valid values for `type` are `AMAZON`, `BYOIP`, `IPAM_POOL`, `OUTPOST`."
  }
}

variable "network_border_group" {
  description = <<EOF
  (Optional) The name of the network border group. A unique set of Availability Zones, Local Zones, or Wavelength Zones from which Amazon Web Services advertises IP addresses. Use this parameter to limit the IP address to this location. IP addresses cannot move between network border groups. Defaults to the region of the VPC.
  EOF
  type        = string
  default     = null
  nullable    = true
}

variable "pool" {
  description = <<EOF
  (Optional) The configuration to allocate an Elastic IP address for `BYOIP`, `IPAM_POOL` or `OUTPOST` types. `pool` as defined below.
    (Required) `id` - The ID of a pool you want to use for allocating an Elastic IP address.
      `BYOIP` -  The ID of EC2 IPv4 address pool.
      `IPAM_POOL` - The ID of an IPAM pool which has an Amazon-provided or BYOIP public IPv4 CIDR provisioned to it.
      `OUTPOST` - The ID of a customer-owned address pool.
    (Optional) `address` - The Elastic IP address from an address pool.
  EOF
  type = object({
    id      = string
    address = optional(string)
  })
  default  = null
  nullable = true

  validation {
    condition = anytrue([
      var.type == "AMAZON" && var.pool == null,
      var.type != "AMAZON" && var.pool != null,
    ])
    error_message = "The `pool` must be provided when `type` is `BYOIP`, `IPAM_POOL` or `OUTPOST`, and must not be provided when `type` is `AMAZON`."
  }
}

variable "timeouts" {
  description = "(Optional) How long to wait for the elastic ip to read/update/delete."
  type = object({
    read   = optional(string, "15m")
    update = optional(string, "5m")
    delete = optional(string, "3m")
  })
  default  = {}
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
