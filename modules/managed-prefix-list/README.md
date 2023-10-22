# managed-prefix-list

This module creates no resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_managed_prefix_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_family"></a> [address\_family](#input\_address\_family) | (Required) Address family of the managed prefix list. Valid values are `IPv4` or `IPv6`. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | (Required) The name of the prefix list. The name must not start with `com.amazonaws`. | `string` | n/a | yes |
| <a name="input_is_global"></a> [is\_global](#input\_is\_global) | (Optional) Whether this is a global prefix list. Default is `false`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_family"></a> [address\_family](#output\_address\_family) | The address family of the prefix list. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the prefix list. |
| <a name="output_entries"></a> [entries](#output\_entries) | A set of prefix list entries. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the prefix list. |
| <a name="output_max_entries"></a> [max\_entries](#output\_max\_entries) | The maximum number of entries of this prefix list. |
| <a name="output_name"></a> [name](#output\_name) | The name of the prefix list. |
| <a name="output_owner"></a> [owner](#output\_owner) | The ID of the AWS account that owns this prefix list. |
| <a name="output_version"></a> [version](#output\_version) | Latest version of this prefix list. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
