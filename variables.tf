## Common
variable "mission_id" {
  type        = string
  description = "ID of the Jedi to safeguard"
}

variable "default_tags" {
  type        = map(any)
  description = "Tags to use on all resources created by the project"
  default = {
    "Project" : "secrets_of_galaxy",
  }
}

## IAM
variable "role_name" {
  type        = string
  description = "Name of the IAM role for The Jedi Council to assume in order to upload new JSON manifests"
  default     = "JediCouncilRole"
}

## S3
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket where Council members will upload location updates"
  default     = "jedi-manifest-store"
}

variable "bucket_key_config" {
  type = object({
    enabled          = bool
    rotation_enabled = bool
    deletion_window  = number
  })
  description = "KMS Key Configuration for S3 Bucket"
  default = {
    enabled          = true,
    rotation_enabled = false
    deletion_window  = 7
  }
}

## Lambda
variable "lambda_name" {
  type        = string
  description = "Name of the Lambda Function to process uploaded manifests"
  default     = "galaxy_secrets_lambda"
}

variable "lambda_config" {
  type = object({
    memory        = number
    concurrency   = number
    runtime       = string
    handler       = string
    log_retention = number
  })
  description = "Configuration for Lambda Function"
  default = {
    memory        = 128
    concurrency   = -1
    runtime       = "nodejs18.x"
    handler       = "index.handler"
    log_retention = 7
  }
}

## Secret Store
variable "secrets_admin" {
  type        = string
  description = "SecretStore Administrator Name"
}

variable "secrets_key_config" {
  type = object({
    enabled          = bool
    rotation_enabled = bool
    deletion_window  = number
  })
  description = "KMS Key Configuration for SecretStore"
  default = {
    enabled          = true,
    rotation_enabled = false
    deletion_window  = 7
  }
}
