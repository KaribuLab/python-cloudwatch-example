variable "name" {
  description = "The name of the log group"
  type        = string
}

variable "retention_in_days" {
  description = "The number of days log events are kept in CloudWatch Logs"
  type        = number
}

variable "metrics_namespace" {
  description = "The namespace to use for metrics"
  type        = string
}

variable "metrics_filter" {
  description = "The filter pattern for extracting metric data out of ingested log events"
  type = list(
    object({
      name      = string
      pattern   = string
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)

}
