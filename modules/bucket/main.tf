resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json

  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }

  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "this" {
  bucket = aws_s3_bucket.this.id

  lambda_function {
    id                  = "S3NotifyLambda"
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
  }
}

module "key" {
  source = "../kms_key"

  alias            = "S3_Encryption"
  description      = "S3 Encryption Key"
  usage            = "ENCRYPT_DECRYPT"
  key_spec         = "SYMMETRIC_DEFAULT"
  enabled          = var.key_config.enabled
  rotation_enabled = var.key_config.rotation_enabled
  deletion_window  = var.key_config.deletion_window
  policy = templatefile("${path.module}/assets/key_policy.tpl.json", {
    account_id = data.aws_caller_identity.this.account_id
    role_arn   = var.allowed_role_arn
  })
  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = var.bucket_name

  rule {
    bucket_key_enabled = var.key_config.enabled
    apply_server_side_encryption_by_default {
      kms_master_key_id = module.key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
