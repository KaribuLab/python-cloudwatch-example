# Configuración de Terragrunt para el entorno QA
locals {
  common_tags           = {
    environment = "development"
  }
}

dependency "logs" {
  config_path = "${get_parent_terragrunt_dir()}/terragrunt/logs"
  mock_outputs = {
    log_group_arn = "arn:aws:logs:us-east-1:123456789012:log-group:my-log-group"
    metrics_filter_names = ["my-metric-filter"]
    metrics_namespace = "my-namespace"
  }
}

dependency "sns" {
  config_path = "${get_parent_terragrunt_dir()}/terragrunt/sns"
  mock_outputs = {
    sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:my-topic"
    queue_arn = "arn:aws:sqs:us-east-1:123456789012:my-queue"
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/terraform/cloudwatch/alarms"
}

inputs = {
  metrics             = dependency.logs.outputs.metrics_filter_names
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_namespace    = dependency.logs.outputs.metrics_namespace
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  fail_actions        = [dependency.sns.outputs.sns_topic_arn]
  ok_actions          = [dependency.sns.outputs.sns_topic_arn]
  tags                = local.common_tags
}
