output "s3_bucket_names" {
  description = "s3 buckets created by s3_source."
  value       = module.s3.bucket_names
  sensitive = true
}

output "s3_uploaded_files" {
  description = "List of uploaded files to the source S3 bucket."
  value       = module.s3.uploaded_files
  sensitive = true
}

output "s3_glue_script" {
  description = "glue script uploaded to the s3 bucket"
  value       = module.s3.glue_script
  sensitive = true
}

output "glue_role_arn" {
  description = "glue role arn"
  value       = module.iam.glue_role_arn
  sensitive = true
}

output "glue_role_name" {
  description = "glue role name"
  value       = module.iam.glue_role_name
  sensitive = true
}

output "source_bucket_arn" {
  value       = module.s3.source_bucket_arn
  description = "arn of the source bucket"
  sensitive = true
}

output "source_crawler_name" {
  value       = module.glue.source_crawler_name
  description = "source crawler name"
  sensitive = true
}
