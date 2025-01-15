variable "prefix" {
  type        = string
  description = "prefix for the project name"
}

variable "source_bucket" {
  type = string
  description = "source bucket name"
}

variable "target_bucket" {
  type = string
  description = "target bucket name"
}

variable "script_bucket" {
  type = string
  description = "script bucket name"
  
}

variable "glue_role_arn" {
  type = string
  description = "glue role arn"
}

variable "s3_glue_script" {
  type        = string
  description = "glue script file"
}