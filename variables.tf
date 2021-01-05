variable "name" {
  default = "mach-lambda-repository"
}

variable "access_principle_identifiers" {
  type = list
  description = "List of user or role ARNs that should be able to access the code repository"
}

variable "deploy_principle_identifier" {
  type = string
  description = "A user or role ARN that should be able to upload to the code repository"
}

variable "noncurrent_version_expiration" {
  type    = number
  default = 30
}