variable "aws_region" {
  description = "aws region"
  default     = "us-east-1"
}

variable "prefix" {
  description = "objects prefix"
  default     = "tf-glue-project"
}

variable "s3_bucket_names" {
  description = "s3 bucket names"
  type        = list(string)
  default = [
    "source",
    "target",
    "scripts"
  ]
}
