# The Jedi Council: Secrets of the Galaxy

The Jedi Council states the `mission_id` which represents the identity of the Jedi whose location needs to be safeguarded.

The council also runs the Terraform code to launch the safeguarding pipeline.

## Usage

1. Create Terraform Inputs

The only required parameters are `mission_id` and `secrets_admin`. The rest are shown with their default values as example.

```shell
echo > terraform.tfvars <<EOF
## Common
mission_id   = "54832"
default_tags = {
    "Project": "secrets_of_galaxy",
}

## IAM
role_name = "JediCouncilRole"

## S3 Bucket
bucket_name = "jedi-manifest-store"
bucket_key_config = {
    enabled = true,
    rotation_enabled = false
    deletion_window = 7
}

## Lambda Function
lambda_name   = "galaxy_secrets_lambda"
lambda_config = {
    memory        = 128
    concurrency   = -1
    runtime       = "nodejs18.x"
    handler       = "index.handler"
    log_retention = 7
}

## Secret Store
secrets_admin      = "terraform"
secrets_key_config = {
    enabled = true,
    rotation_enabled = false
    deletion_window = 7
}
EOF
```

2. Init Terraform Plan
```shell
## Initialize Terraform
terraform init

## Plan Terraform resources
terraform plan
```

3. Prepare Lambda code dependencies
```shell
## Change Directory to Lambda code directory
cd lambda/

## Install Lambda code dependencies
npm install
```

4. Apply Terraform Plan
```shell
## Automatically package Lambda code & create AWS resources
terraform apply --auto-approve
```

## Architecture

Jedi Council members can assume the `JediCouncilRole` IAM role which allows to upload a `manifest.json` file to an encrypted S3 bucket.

The S3 bucket is configured to send a notification on new object creation event to trigger a Lambda function.

This Lambda function processes the S3 event:

- Fetch Manifest from S3
- Scan manifest file to look for target Jedi ID (`mission_id`)
    - If found, update secret data on Secrets Manager
- Log latest target Jedi data to CloudWatch Log

### IAM

- `JediCouncilRole` role assumable by Lambda function
- `JediCouncilRolePolicy`
    - Allow Cloudwatch Log Creation
    - Allow manifest retrieval from S3 bucket
    - Encrypt and Decrypt target Jedi secret on Secrets Manager

### S3 Bucket

- Members of the council can upload new manifests with Jedi location updates
- Event Notification to trigger lambda function

### Lambda

- Triggered by S3 Notification Event
- Fetch Manifest from S3
- Scan manifest file to look for target Jedi ID (`mission_id`)
    - If found, update secret data on Secrets Manager
- Log latest target Jedi data to CloudWatch Log group

### Secret Store

- Secret for the target Jedi

### KMS

- Key to encrypt S3 bucket content
- Key to encrypt target Jedi secret
