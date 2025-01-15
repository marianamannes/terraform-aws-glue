resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "${var.prefix}-database"
  location_uri = "s3://${var.source_bucket}"
}

resource "aws_glue_crawler" "aws_source_crawler" {
  name          = "${var.prefix}-source-crawler"
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  role          = var.glue_role_arn

  s3_target {
    path = "s3://${var.source_bucket}/"
  }
}

resource "aws_glue_trigger" "aws_source_crawler_trigger" {
  name = "${var.prefix}-source-crawler-trigger"
  type = "ON_DEMAND"
  actions {
    crawler_name = aws_glue_crawler.aws_source_crawler.name
  }
}

resource "aws_glue_job" "aws_glue_job" {
  name     = "${var.prefix}-glue-job"
  role_arn = var.glue_role_arn

  command {
    script_location = "s3://${var.script_bucket}/${var.s3_glue_script}"
    python_version  = "3"
  }

  glue_version        = "3.0"
  default_arguments = {
    "--JOB_NAME"      = "${var.prefix}-glue-job"
    "--DATABASE_NAME" = aws_glue_catalog_database.aws_glue_catalog_database.name
    "--TABLE_NAME"    = replace(var.source_bucket, "-", "_")
    "--TARGET_BUCKET" = "s3://${var.target_bucket}"
    "--job-bookmark-option" = "job-bookmark-enable"
  }

  depends_on = [
    aws_glue_crawler.aws_source_crawler,
    aws_glue_trigger.aws_source_crawler_trigger
  ]

}

resource "aws_glue_trigger" "aws_job_trigger" {
  name = "${var.prefix}-job-trigger"
  type = "CONDITIONAL"

  predicate {
    conditions {
      crawler_name = aws_glue_crawler.aws_source_crawler.name
      crawl_state = "SUCCEEDED"
      logical_operator = "EQUALS"
    }
  }

  actions {
    job_name = aws_glue_job.aws_glue_job.name
  }
}

resource "aws_glue_crawler" "aws_target_crawler" {
  name          = "${var.prefix}-target-crawler"
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  role          = var.glue_role_arn

  s3_target {
    path = "s3://${var.target_bucket}/"
  }
  
}

resource "aws_glue_trigger" "aws_target_crawler_trigger" {
  name = "${var.prefix}-target-crawler-trigger"
  type = "CONDITIONAL"

  actions {
    crawler_name = aws_glue_crawler.aws_target_crawler.name
  }

  predicate {
    conditions {
      logical_operator = "EQUALS"
      job_name         = aws_glue_job.aws_glue_job.name
      state            = "SUCCEEDED"
    }
  }
}
