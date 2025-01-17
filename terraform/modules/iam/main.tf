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

resource "aws_iam_role" "lambda_role" {
  name               = "${var.prefix}-lambda-role-${var.account_id}"
  path               = "/"
  description        = "iam role for lambda to start glue crawler"
  assume_role_policy = file("./modules/iam/permissions/lambda_role.json")
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.prefix}-lambda-policy-${var.account_id}"
  path        = "/"
  description = "iam policy for gambda to start glue crawler and log to cloudwatch"
  policy      = file("./modules/iam/permissions/lambda_policy.json")
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
