// This is the primary bucket
resource "aws_s3_bucket" "code_repository" {
  bucket = var.code_repo_name
  acl    = "private"

  versioning {
    enabled = true
  }
}

# Access policy for the s3 bucket
data "aws_iam_policy_document" "s3_code_repository" {
  # Allow uploads from the deploy role in the service account. This role is
  # assumed by jenkins to upload new objects in the bucket
  statement {
    principals {
      type = "AWS"
      identifiers = var.access_principle_identifiers
    }

    actions = ["s3:GetObject", "s3:PutObject"]

    resources = [
      "arn:aws:s3:::${var.code_repo_name}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "code_repository" {
  bucket = aws_s3_bucket.code_repository.id
  policy = data.aws_iam_policy_document.s3_code_repository.json
}

output "code_repository_arn" {
  value = aws_s3_bucket.code_repository.arn
}
