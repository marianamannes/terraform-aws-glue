resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "${var.prefix}-database"
  location_uri = "s3://${var.source_bucket}"
}