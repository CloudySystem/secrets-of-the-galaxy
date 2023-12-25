data "aws_region" "this" {}
data "archive_file" "this" {
  type = "zip"

  source_dir = "${path.module}/../../lambda"
  excludes   = ["*.log", ".*"]

  output_path      = "${path.module}/assets/lambda.zip"
  output_file_mode = "0666"
}
