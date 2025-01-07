resource "aws_iam_policy" "glue_job" {
  name        = "${var.prefix}-glue-job-policy-${var.account_id}"
  path        = "/"
  description = "creates glue job iam policy"
  policy      = file("./modules/iam/permissions/glue_policy.json")
}

resource "aws_iam_role" "glue_job" {
  name               = "${var.prefix}-glue-job-role-${var.account_id}"
  path               = "/"
  description        = "creates glue job iam role"
  assume_role_policy = file("./modules/iam/permissions/glue_role.json")
}

resource "aws_iam_role_policy_attachment" "glue_job" {
  role       = aws_iam_role.glue_job.name
  policy_arn = aws_iam_policy.glue_job.arn
}