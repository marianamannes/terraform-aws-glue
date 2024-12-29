variable "account_id" {
  type        = string
  description = "aws account id"
}

variable "prefix" {
  type        = string
  description = "prefix for the bucket names"
}

variable "s3_bucket_names" {
  type        = list(string)
  description = "list of names for the s3 buckets"
}
