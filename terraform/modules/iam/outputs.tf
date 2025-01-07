output "glue_role_arn" {
  description = "glue role arn"
  value       = aws_iam_role.glue_job.arn
}

output "glue_role_name" {
  description = "glue role name"
  value       = aws_iam_role.glue_job.name
}