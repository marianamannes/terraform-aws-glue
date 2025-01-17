variable "account_id" {
  type        = string
  description = "aws account id"
}

variable "prefix" {
  type        = string
  description = "prefix for the project name"
}

variable "s3_bucket_names" {
  type        = list(string)
  description = "list of names for the s3 buckets"
}

variable "mock_data_files" {
  type        = list(string)
  description = "list of files to upload to the source bucket"
}

variable "mock_data_path" {
  type        = string
  description = "path to the mock_data directory containing files to upload"
}

variable "glue_script_file" {
  type        = string
  description = "glue script file"
}

variable "glue_script_path" {
  type        = string
  description = "path to the glue script directory"
}
