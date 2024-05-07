variable "service" {
  description = "(Required) The service name of the prefix list. The service name must not start with `com.amazonaws`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["cloudfront.origin-facing", "dynamodb", "groundstation", "route53-healthchecks", "s3", "s3express", "vpc-lattice"], var.service)
    error_message = "Valid values for `service` are `cloudfront.origin-facing`, `dynamodb`, `groundstation`, `route53-healthchecks`, `s3`, `s3express`, `vpc-lattice`."
  }
}

variable "is_global" {
  description = "(Optional) Whether this is a global prefix list. Default is `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "address_family" {
  description = "(Required) Address family of the managed prefix list. Valid values are `IPv4` or `IPv6`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["IPv4", "IPv6"], var.address_family)
    error_message = "Valid values for `address_family` are `IPv4` or `IPv6`."
  }
}
