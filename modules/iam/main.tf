resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  role = aws_iam_role.this.id

  name = "${var.role_name}Policy"
  policy = templatefile("${path.module}/assets/policy.tpl.json", {
    account_id : data.aws_caller_identity.this.account_id
    region : data.aws_region.this.name
    bucket_name : var.bucket_name
    secret_arn : var.secret_arn
  })
}
