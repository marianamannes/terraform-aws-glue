resource "aws_s3_bucket" "buckets" {
  count  = length(var.s3_bucket_names)
  bucket = "${var.prefix}-${var.s3_bucket_names[count.index]}-${var.account_id}"

  force_destroy = true
}

resource "aws_s3_object" "mock_data_files" {
  for_each = { for file in var.mock_data_files : file => file }

  bucket = aws_s3_bucket.buckets[0].bucket
  key    = each.key
  source = "${var.mock_data_path}/${each.key}"
  source_hash = filemd5("${var.mock_data_path}/${each.key}")
  acl    = "private"

}

resource "aws_s3_object" "glue_job" {
  bucket = aws_s3_bucket.buckets[2].bucket
  key    = "${var.prefix}-${var.glue_script_file}"
  source = "${var.glue_script_path}/${var.glue_script_file}"
  source_hash = filemd5("${var.glue_script_path}/${var.glue_script_file}")
  acl    = "private"

}