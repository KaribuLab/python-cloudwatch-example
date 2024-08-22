locals {
  aws_region    = get_env("AWS_REGION")
  bucket_name   = "python-cloudwatch-example-infra"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "aws" {
    region = "${local.aws_region}"
  }
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket                      = local.bucket_name
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    region                      = "${local.aws_region}"
    encrypt                     = true
    dynamodb_table              = "${local.bucket_name}-${local.aws_region}-tfstate-lock"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

inputs = merge({
    bucket_name = local.bucket_name
    aws_region  = local.aws_region
})