variable "topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

variable "topic_delivery_policy" {
  description = "The delivery policy of the SNS topic"
  type        = string
  
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
