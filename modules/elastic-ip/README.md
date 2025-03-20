# elastic-ip

This module creates following resources.

- `aws_eip`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Elastic IP. | `string` | n/a | yes |
| <a name="input_ipam_pool"></a> [ipam\_pool](#input\_ipam\_pool) | (Optional) The configuration to allocate an Elastic IP address from the IPAM pool. Required if `type` is `IPAM_POOL`. `ipam_pool` as defined below.<br>    (Required) `id` - The ID of an IPv4 IPAM public pool you want to use for allocating an Elastic IP address.<br>    (Optional) `address` - The Elastic IP address to recover or an IPv4 address from an address pool. | <pre>object({<br>    id      = string<br>    address = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_network_border_group"></a> [network\_border\_group](#input\_network\_border\_group) | (Optional) The name of the network border group. A unique set of Availability Zones, Local Zones, or Wavelength Zones from which Amazon Web Services advertises IP addresses. Use this parameter to limit the IP address to this location. IP addresses cannot move between network border groups. Defaults to the region of the VPC. | `string` | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the elastic ip to read/update/delete. | <pre>object({<br>    read   = optional(string, "15m")<br>    update = optional(string, "5m")<br>    delete = optional(string, "3m")<br>  })</pre> | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) The type of the Elastic IP to decide how to allocate. Valid values are `AMAZON`, `IPAM_POOL` and `OUTPOST`. Defaults to `AMAZON`. | `string` | `"AMAZON"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allocation_id"></a> [allocation\_id](#output\_allocation\_id) | The allocation ID of the Elastic IP. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Elastic IP. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Elastic IP. |
| <a name="output_network_border_group"></a> [network\_border\_group](#output\_network\_border\_group) | The name of the network border group. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The Elastic IP address. |
| <a name="output_scope"></a> [scope](#output\_scope) | The scope of the Elastic IP address. |
| <a name="output_type"></a> [type](#output\_type) | The type of the Elastic IP address. |
<!-- END_TF_DOCS -->
