output "s3_bucket_names" {
  description = "s3 buckets created by s3_source."
  value       = module.s3_source.bucket_names
}