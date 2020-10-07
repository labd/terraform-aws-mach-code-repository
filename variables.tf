variable "name" {
  default = "mach-lambda-repository"
}

variable "access_principle_identifiers" {
  type = list
  description = "List of user or role ARNs that should be able to access the code repository"
}