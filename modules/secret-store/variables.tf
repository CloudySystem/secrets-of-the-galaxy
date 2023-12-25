variable "mission_id" {
  type        = string
  description = "ID of the Jedi to look for on the Mission requested by the Council"
}

variable "secrets_admin" {
  type        = string
  description = "SecretStore Administrator Name"
}

variable "allowed_role_arn" {
  type        = string
  description = "ARN of the IAM Role to be allowed to decrypt Secrets"
}

variable "key_config" {
  type = object({
    enabled          = bool,
    rotation_enabled = bool
    deletion_window  = number
  })
  description = "KMS key configuration"
}

variable "tags" {
  type    = map(any)
  default = {}
}
