# terraform-aws-ipam

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-ipam?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-ipam?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform module which creates IPAM related resources (IPAM, Elastic IP, Prefix List) on AWS.

- [ipam](./modules/ipam)
- [ipam-resource-discovery](./modules/ipam-resource-discovery)
- [prefix-list](./modules/prefix-list)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-ipam) were written to manage the following AWS Services with Terraform.

- **AWS VPC (Virtual Private Cloud)**
  - Prefix List
  - Elastic IP
- **AWS VPC IPAM (IP Address Manager)**
  - IPAM
  - Scope
  - Pool
  - Resource Discovery


## Examples

### VPC

- [prefix-lists](./examples/prefix-lists)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-ipam). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2023, [Byungjin Park](https://www.posquit0.com).
