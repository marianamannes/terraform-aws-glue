output "bucket_names" {
  description = "list of names of the created s3 buckets"
  value       = aws_s3_bucket.buckets[*].bucket
}

output "uploaded_files" {
  description = "list of uploaded files to the source s3 bucket"
  value       = [for obj in aws_s3_object.mock_data_files : obj.key]
}

output "glue_script" {
  description = "glue script uploaded to the s3 bucket"
  value       = aws_s3_object.glue_job.key
}