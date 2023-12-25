variable "alias" {
  type        = string
  description = "KMS Key Alias"
}

variable "description" {
  type        = string
  description = "KMS Key Description"
}

variable "usage" {
  type        = string
  description = "KMS Key Usage"
  default     = "ENCRYPT_DECRYPT"
}

variable "key_spec" {
  type        = string
  description = "KMS Master Key Spec"
  default     = "SYMMETRIC_DEFAULT"
}

variable "enabled" {
  type        = bool
  description = "Enabled/Disable KMS Key"
}

variable "rotation_enabled" {
  type        = bool
  description = "Enable/Disable Key Rotation"
}

variable "deletion_window" {
  type        = number
  description = "KMS Key Deletion Window in days"
}

variable "policy" {
  type        = string
  description = "KMS Key IAM Policy"
}

variable "tags" {
  type    = map(any)
  default = {}
}
