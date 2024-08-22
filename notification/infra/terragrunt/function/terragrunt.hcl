terraform {
  source = "${get_parent_terragrunt_dir()}/infra/terraform/function"
}

locals {
  function_name = "python-cloudwatch-example-notification"
  common_tags   = {
    environment = "development"
  }
}

include {
  path = find_in_parent_folders()
}

dependency log {
  config_path = "${get_parent_terragrunt_dir()}/infra/terragrunt/log"
  mock_outputs = {
    log_arn = "log_arn"
  }
}

inputs = {
  function_name = local.function_name
  iam_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${dependency.log.outputs.log_arn}:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
        ],
        "Resource" : ["arn:aws:sqs:us-west-2:${get_env("AWS_ACCOUNT_ID")}:python-cloudwatch-example-queue"]
      },
    ]
  })
  environment_variables = {
    SLACK_WEBHOOK_URL: get_env("SLACK_WEBHOOK_URL")
  }
  module_bucket = "python-cloudwatch-example-notification"
  file_location = "${get_parent_terragrunt_dir()}/output"
  zip_location  = "${get_parent_terragrunt_dir()}/dist"
  zip_name      = "${local.function_name}.zip"
  common_tags   = local.common_tags
  event_sources_arn = ["arn:aws:sqs:us-west-2:${get_env("AWS_ACCOUNT_ID")}:python-cloudwatch-example-queue"]
}
