variable "bucket_name" {
  type        = string
  description = "Globally Unique Bucket Name"
}

variable "lambda_arn" {
  type        = string
  description = "ARN of the Lambda to send Notification Events to"
}

variable "allowed_role_arn" {
  type        = string
  description = "ARN of the IAM Role to be allowed to decrypt S3 Objects"
}

variable "key_config" {
  type = object({
    enabled          = bool,
    rotation_enabled = bool
    deletion_window  = number
  })
  description = "KMS Key Configuration"
}

variable "tags" {
  type    = map(any)
  default = {}
}
