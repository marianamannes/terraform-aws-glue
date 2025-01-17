resource "aws_lambda_function" "trigger_source_crawler" {
  filename         = "${path.root}/../scripts/lambda_function.zip"
  function_name    = "${var.prefix}-trigger-source-crawler"
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("${path.root}/../scripts/lambda_function.zip")

  environment {
    variables = {
      CRAWLER_NAME = var.crawler_name
    }
  }
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowS3Invocation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger_source_crawler.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.source_bucket_arn
}


resource "aws_s3_bucket_notification" "source_bucket_notification" {
  bucket = var.source_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.trigger_source_crawler.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = ""
  }

  depends_on = [ aws_lambda_function.trigger_source_crawler ]
}