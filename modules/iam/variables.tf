variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket where Council members will upload location updates"
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role for The Jedi Council to assume in order to upload new JSON manifests"
}

variable "secret_arn" {
  type        = string
  description = "ARN of the Secret"
}

variable "tags" {
  type    = map(any)
  default = {}
}
