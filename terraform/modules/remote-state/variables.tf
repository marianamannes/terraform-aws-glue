variable "aws_region" {
  description = "aws region"
  default     = "us-east-1"
}

variable "prefix" {
  description = "objects prefix"
  default     = "tf-glue-project"
}

variable "s3_backend_bucket" {
  type        = string
  description = "s3 bucket name for terraform backend"
  default     = "tf-state"
}