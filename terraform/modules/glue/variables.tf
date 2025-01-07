variable "prefix" {
  type        = string
  description = "prefix for the project name"
}

variable "source_bucket" {
  type = string
  description = "source bucket name"
}

variable "glue_role_arn" {
  type = string
  description = "glue role arn"
}