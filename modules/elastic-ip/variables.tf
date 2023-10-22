variable "name" {
  description = "(Required) The name of the Elastic IP."
  type        = string
  nullable    = false
}

variable "type" {
  description = <<EOF
  (Optional) The type of the Elastic IP to decide how to allocate. Valid values are `AMAZON`, `IPAM_POOL` and `OUTPOST`. Defaults to `AMAZON`.
  EOF
  type        = string
  default     = "AMAZON"
  nullable    = false

  validation {
    condition     = contains(["AMAZON", "IPAM_POOL", "OUTPOST"], var.type)
    error_message = "Valid values for `type` are `AMAZON`, `IPAM_POOL`, `OUTPOST`."
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

variable "ipam_pool" {
  description = <<EOF
  (Optional) The configuration to allocate an Elastic IP address from the IPAM pool. Required if `type` is `IPAM_POOL`. `ipam_pool` as defined below.
    (Required) `id` - The ID of an IPv4 IPAM public pool you want to use for allocating an Elastic IP address.
    (Optional) `address` - The Elastic IP address to recover or an IPv4 address from an address pool.
  EOF
  type = object({
    id      = string
    address = optional(string)
  })
  default  = null
  nullable = true
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

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
