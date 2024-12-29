resource "aws_s3_bucket" "buckets" {
  count  = length(var.s3_bucket_names)
  bucket = "${var.prefix}-${var.s3_bucket_names[count.index]}-${var.account_id}"

  force_destroy = true
}