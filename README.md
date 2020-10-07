# AWS code repository module

Module to set up a S3 Bucket which can serve as lambda code repository

## Usage

```
module "coderepository" {
  source = "git::https://git.labdigital.nl/mach/terraform/terraform-aws-code-repository.git"
}
```