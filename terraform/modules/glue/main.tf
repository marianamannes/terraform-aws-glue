resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "${var.prefix}-database"
  location_uri = "s3://${var.source_bucket}"
}

resource "aws_glue_crawler" "aws_glue_crawler" {
  name          = "${var.prefix}-crawler"
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  role          = var.glue_role_arn

  s3_target {
    path = "s3://${var.source_bucket}/"
  }
}

resource "aws_glue_trigger" "aws_glue_trigger" {
  name = "${var.prefix}-crawler-trigger"
  type = "ON_DEMAND"
  actions {
    crawler_name = aws_glue_crawler.aws_glue_crawler.name
  }
}