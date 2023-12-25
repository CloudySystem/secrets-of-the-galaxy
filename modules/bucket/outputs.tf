output "domain" {
  value = "${aws_s3_bucket.this.id}.s3.amazonaws.com"
}

output "arn" {
  value = aws_s3_bucket.this.arn
}

output "name" {
  value = aws_s3_bucket.this.id
}

output "key_arn" {
  value = module.key.arn
}
