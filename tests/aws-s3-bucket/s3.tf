resource "aws_s3_bucket" "storage" {
  provider = aws.target
  bucket   = var.backend_config_bucket
}

resource "aws_s3_bucket_policy" "storage" {
  provider = aws.target
  bucket   = aws_s3_bucket.storage.id
  policy   = data.aws_iam_policy_document.storage.json
}

data "aws_iam_policy_document" "storage" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [local.reader_role_arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.storage.arn,
      "${aws_s3_bucket.storage.arn}/*",
    ]
  }
}
