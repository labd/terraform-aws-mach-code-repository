# AWS code repository module

Module to set up a S3 Bucket which can serve as lambda code repository

## Usage

```
module "coderepository" {
  source = "git::https://github.com/labd/terraform-aws-mach-code-repository.git"
  name   = "your-project-lambdas"

  access_principle_identifiers = [
      "arn:aws:iam::000000000000:user/mach-user", # MACH Test env
      "arn:aws:iam::000000000000:user/mach-user", # MACH Acc env
      "arn:aws:iam::000000000000:user/mach-user", # MACH Prod env
  ]

  deploy_principle_identifiers = []
}
```
