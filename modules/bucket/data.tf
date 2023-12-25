data "aws_caller_identity" "this" {}
data "aws_iam_policy_document" "this" {
  statement {
    sid     = "AllowReadAccess"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
