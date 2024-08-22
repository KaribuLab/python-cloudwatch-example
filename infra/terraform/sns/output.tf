output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.event.arn
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.event.arn
}
