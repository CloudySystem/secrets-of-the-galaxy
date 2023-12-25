module "iam" {
  source = "./modules/iam"

  bucket_name = var.bucket_name
  role_name   = var.role_name
  secret_arn  = module.secrets.secret_arn

  tags = merge(var.default_tags, {
    "Component" : "iam"
  })
}

module "bucket" {
  source = "./modules/bucket"

  bucket_name      = var.bucket_name
  lambda_arn       = module.lambda.arn
  allowed_role_arn = module.iam.lambda_role_arn
  key_config       = var.bucket_key_config

  tags = merge(var.default_tags, {
    "Component" : "bucket"
  })
}

module "lambda" {
  source = "./modules/lambda"

  name          = var.lambda_name
  bucket_arn    = module.bucket.arn
  role_arn      = module.iam.lambda_role_arn
  mission_id    = var.mission_id
  lambda_config = var.lambda_config

  tags = merge(var.default_tags, {
    "Component" : "lambda"
  })
}

module "secrets" {
  source = "./modules/secret-store"

  mission_id       = var.mission_id
  secrets_admin    = var.secrets_admin
  allowed_role_arn = module.iam.lambda_role_arn
  key_config       = var.secrets_key_config

  tags = merge(var.default_tags, {
    "Component" : "secret-store"
  })
}
