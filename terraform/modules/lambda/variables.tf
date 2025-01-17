variable "prefix" {
  type        = string
  description = "objects prefix"
}

variable "crawler_name" {
  type        = string
  description = "glue crawler name to trigger"
}

variable "source_bucket" {
  type        = string
  description = "source bucket name"
}

variable "source_bucket_arn" {
  type        = string
  description = "arn of the source s3 bucket"
}

variable "lambda_role_arn" {
  type        = string
  description = "arn of the iam to attach to the lambda function"
}