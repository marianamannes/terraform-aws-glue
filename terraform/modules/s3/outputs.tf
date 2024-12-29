output "bucket_names" {
  description = "list of names of the created S3 buckets."
  value       = aws_s3_bucket.buckets[*].bucket
}
