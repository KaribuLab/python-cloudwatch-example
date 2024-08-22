variable "metrics" {
  description = "List of metrics"
  type        = list(string)
}

variable "comparison_operator" {
  description = "Comparison operator to use"
  type        = string
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate the metric"
  type        = number
}

variable "metric_namespace" {
  description = "Namespace of the metric"
  type        = string
}

variable "period" {
  description = "Period of the metric"
  type        = number
}

variable "statistic" {
  description = "Statistic to apply to the metric"
  type        = string
}

variable "threshold" {
  description = "Threshold to trigger the alarm"
  type        = number
}

variable "fail_actions" {
  description = "List of fail actions to execute when an alarm is triggered"
  type        = list(string)
}

variable "ok_actions" {
  description = "List of ok actions to execute when an alarm is resolved"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
