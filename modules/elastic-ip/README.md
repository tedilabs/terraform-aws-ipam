# elastic-ip

This module creates following resources.

- `aws_eip`
- `aws_eip_domain_name` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.14.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_domain_name) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Elastic IP. | `string` | n/a | yes |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_network_border_group"></a> [network\_border\_group](#input\_network\_border\_group) | (Optional) The name of the network border group. A unique set of Availability Zones, Local Zones, or Wavelength Zones from which Amazon Web Services advertises IP addresses. Use this parameter to limit the IP address to this location. IP addresses cannot move between network border groups. Defaults to the region of the VPC. | `string` | `null` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | (Optional) The configuration to allocate an Elastic IP address for `BYOIP`, `IPAM_POOL` or `OUTPOST` types. `pool` as defined below.<br/>    (Required) `id` - The ID of a pool you want to use for allocating an Elastic IP address.<br/>      `BYOIP` -  The ID of EC2 IPv4 address pool.<br/>      `IPAM_POOL` - The ID of an IPAM pool which has an Amazon-provided or BYOIP public IPv4 CIDR provisioned to it.<br/>      `OUTPOST` - The ID of a customer-owned address pool.<br/>    (Optional) `address` - The Elastic IP address from an address pool. | <pre>object({<br/>    id      = string<br/>    address = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_reverse_domain_name"></a> [reverse\_domain\_name](#input\_reverse\_domain\_name) | (Optional) The reverse DNS domain name for the Elastic IP address. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the elastic ip to read/update/delete. | <pre>object({<br/>    read   = optional(string, "15m")<br/>    update = optional(string, "5m")<br/>    delete = optional(string, "3m")<br/>  })</pre> | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) The type of the Elastic IP to decide how to allocate. Valid values are `AMAZON`, `BYOIP`, `IPAM_POOL` and `OUTPOST`. Defaults to `AMAZON`. | `string` | `"AMAZON"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allocation_id"></a> [allocation\_id](#output\_allocation\_id) | The allocation ID of the Elastic IP. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Elastic IP. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Elastic IP. |
| <a name="output_network_border_group"></a> [network\_border\_group](#output\_network\_border\_group) | The name of the network border group. |
| <a name="output_pool"></a> [pool](#output\_pool) | The pool configuration of the Elastic IP address for `BYOIP`, `IPAM_POOL` or `OUTPOST` types. |
| <a name="output_private_domain"></a> [private\_domain](#output\_private\_domain) | The private domain associated with the Elastic IP address. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The Private IP address. |
| <a name="output_public_domain"></a> [public\_domain](#output\_public\_domain) | The public domain associated with the Elastic IP address. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The Elastic IP address. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_reverse_domain_name"></a> [reverse\_domain\_name](#output\_reverse\_domain\_name) | The reverse DNS domain name for the Elastic IP address. |
| <a name="output_type"></a> [type](#output\_type) | The type of the Elastic IP address. |
<!-- END_TF_DOCS -->
