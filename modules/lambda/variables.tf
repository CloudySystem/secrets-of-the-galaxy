variable "mission_id" {
  type        = string
  description = "ID of the Jedi to safeguard"
}

variable "name" {
  type        = string
  description = "Lambda Function Name"
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the S3 Bucket which will invoke the Lambda Function"
}

variable "role_arn" {
  type        = string
  description = "ARN of the IAM role which will be used when invoking the Lambda Function"
}

variable "lambda_config" {
  type = object({
    memory        = number
    concurrency   = number
    runtime       = string
    handler       = string
    log_retention = number
  })
  description = "KMS Key Configuration"
}

variable "tags" {
  type    = map(any)
  default = {}
}
