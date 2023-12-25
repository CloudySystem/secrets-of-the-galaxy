output "arn" {
  value = aws_kms_key.this.arn
}

output "id" {
  value = aws_kms_key.this.id
}

output "alias_id" {
  value = aws_kms_alias.this.id
}

output "alias_target_id" {
  value = aws_kms_alias.this.target_key_id
}

output "alias_target_arn" {
  value = aws_kms_alias.this.target_key_arn
}
