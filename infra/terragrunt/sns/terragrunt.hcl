locals {
  common_tags           = {
    environment = "development"
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/terraform/sns"
}

inputs = {
  topic_name                    = "python-cloudwatch-example-sns"
  topic_delivery_policy         = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget = 20,
        maxDelayTarget = 20,
        numRetries = 3,
        numMaxDelayRetries = 0,
        numNoDelayRetries = 0,
        numMinDelayRetries = 0,
        backoffFunction = "linear"
      },
      disableSubscriptionOverrides = false,
      defaultThrottlePolicy = {
        maxReceivesPerSecond = 1
      }
    }
  })
  queue_name                    = "python-cloudwatch-example-queue"
  tags                    = local.common_tags
}
