output "alarms_arn" {
  description = "The ARN of the alarms"
  value       = aws_cloudwatch_metric_alarm.alarm[*].arn
}
