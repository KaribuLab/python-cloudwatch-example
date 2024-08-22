output "log_group_arn" {
  description = "The ARN of the log group"
  value       = aws_cloudwatch_log_group.logs.arn
}

output "metrics_filter_names" {
  description = "Metrics filter names"
  value       = aws_cloudwatch_log_metric_filter.logs[*].name
}

output "metrics_namespace" {
  description = "Metrics namespace"
  value       = var.metrics_namespace
}
