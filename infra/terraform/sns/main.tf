terraform {
  backend "s3" {}
}

resource "aws_sns_topic" "event" {
  name            = var.topic_name
  delivery_policy = var.topic_delivery_policy
  tags            = var.tags
}

resource "aws_sqs_queue" "event_dlq" {
  name = "${var.queue_name}_dlq"
  tags = var.tags
}

resource "aws_sqs_queue" "event" {
  name = var.queue_name
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.event_dlq.arn
    maxReceiveCount     = 3
  })
  tags = var.tags
}

resource "aws_sns_topic_subscription" "event" {
  topic_arn = aws_sns_topic.event.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.event.arn
}

resource "aws_sqs_queue_policy" "event" {
  queue_url = aws_sqs_queue.event.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Allow-SNS-Event",
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.event.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.event.arn
          }
        }
      }
    ]
  })
}
