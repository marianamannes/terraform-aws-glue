variable "prefix" {
  type        = string
  description = "objects prefix"
}

variable "crawler_name" {
  type        = string
  description = "glue crawler name to trigger"
  sensitive = true
}

variable "source_bucket" {
  type        = string
  description = "source bucket name"
  sensitive = true
}

variable "source_bucket_arn" {
  type        = string
  description = "arn of the source s3 bucket"
  sensitive = true
}

variable "lambda_role_arn" {
  type        = string
  description = "arn of the iam to attach to the lambda function"
  sensitive = true
}