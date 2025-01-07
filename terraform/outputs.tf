output "s3_bucket_names" {
  description = "s3 buckets created by s3_source."
  value       = module.s3.bucket_names
}

output "s3_uploaded_files" {
  description = "List of uploaded files to the source S3 bucket."
  value       = module.s3.uploaded_files
}