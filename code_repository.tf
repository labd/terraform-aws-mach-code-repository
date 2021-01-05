// This is the primary bucket
resource "aws_s3_bucket" "code_repository" {
  bucket = var.name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "auto-delete-expired-versions"
    enabled = true

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration
    }
  }

  lifecycle_rule {
    id                                     = "auto-delete-incomplete-after-x-days"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 2
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

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::${var.name}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "code_repository" {
  bucket = aws_s3_bucket.code_repository.id
  policy = data.aws_iam_policy_document.s3_code_repository.json
}

resource "aws_s3_bucket_public_access_block" "primary" {
  bucket = aws_s3_bucket.code_repository.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "code_repository_arn" {
  value = aws_s3_bucket.code_repository.arn
}
