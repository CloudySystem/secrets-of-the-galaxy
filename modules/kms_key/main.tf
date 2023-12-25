resource "aws_kms_key" "this" {
  key_usage                = var.usage
  customer_master_key_spec = var.key_spec
  description              = var.description
  is_enabled               = var.enabled
  enable_key_rotation      = var.rotation_enabled
  deletion_window_in_days  = var.deletion_window
  policy                   = var.policy
  tags                     = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}
