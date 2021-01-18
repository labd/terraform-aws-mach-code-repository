data "aws_iam_policy_document" "upload_lambda_document" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      format("%s/*", aws_s3_bucket.code_repository.arn)
    ]
  }
}

resource "aws_iam_role_policy" "upload_lambda_policy" {
  for_each = toset(var.deploy_principle_identifiers)
  name     = "upload-lambda-policy"
  role     = each.value
  policy   = data.aws_iam_policy_document.upload_lambda_document.json
}