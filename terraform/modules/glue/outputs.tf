output "database_name" {
  description = "glue catalog database name"
  value       = aws_glue_catalog_database.aws_glue_catalog_database.name
  sensitive = true
}

output "source_crawler_name" {
  value = aws_glue_crawler.aws_source_crawler.name
  sensitive = true
}
