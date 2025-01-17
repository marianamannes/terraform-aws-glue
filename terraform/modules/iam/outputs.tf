output "glue_role_arn" {
  description = "glue role arn"
  value       = aws_iam_role.glue_job.arn
}

output "glue_role_name" {
  description = "glue role name"
  value       = aws_iam_role.glue_job.name
}

output "lambda_role_arn" {
  value       = aws_iam_role.lambda_role.arn
  description = "arn of the iam role for the lambda function"
}
