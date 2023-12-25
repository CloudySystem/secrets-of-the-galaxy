resource "aws_secretsmanager_secret" "this" {
  name        = var.mission_id
  description = "Secret data about Jedi ${var.mission_id}"
  kms_key_id  = module.key.alias_target_arn
  tags        = var.tags
}

module "key" {
  source = "../kms_key"

  alias            = var.mission_id
  description      = "Key of Jedi ${var.mission_id}"
  usage            = "ENCRYPT_DECRYPT"
  key_spec         = "SYMMETRIC_DEFAULT"
  enabled          = var.key_config.enabled
  rotation_enabled = var.key_config.rotation_enabled
  deletion_window  = var.key_config.deletion_window
  policy = templatefile("${path.module}/assets/key_policy.tpl.json", {
    account_id     = data.aws_caller_identity.this.account_id
    admin_username = var.secrets_admin
    role_arn       = var.allowed_role_arn
  })
  tags = var.tags
}
