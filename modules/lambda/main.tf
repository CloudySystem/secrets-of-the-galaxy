resource "aws_lambda_function" "this" {
  function_name = var.name
  role          = var.role_arn

  filename                       = "${path.module}/assets/lambda.zip"
  handler                        = var.lambda_config.handler
  source_code_hash               = data.archive_file.this.output_base64sha256
  memory_size                    = var.lambda_config.memory
  reserved_concurrent_executions = var.lambda_config.concurrency
  runtime                        = var.lambda_config.runtime

  environment {
    variables = {
      mission_id = var.mission_id
      region     = data.aws_region.this.name
    }
  }

  tags = var.tags
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.lambda_config.log_retention
  lifecycle {
    prevent_destroy = false
  }
}

