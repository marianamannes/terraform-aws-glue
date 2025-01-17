variable "account_id" {
  type        = string
  description = "aws account id"
  sensitive = true
}

variable "prefix" {
  type        = string
  description = "prefix for the project name"
}
