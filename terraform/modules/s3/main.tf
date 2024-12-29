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
  acl    = "private"

}