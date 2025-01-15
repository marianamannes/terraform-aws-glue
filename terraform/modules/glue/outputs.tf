output "database_name" {
  description = "glue catalog database name"
  value       = aws_glue_catalog_database.aws_glue_catalog_database.name
}