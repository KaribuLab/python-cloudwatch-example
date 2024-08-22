terraform {
  backend "s3" {}
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  count               = length(var.metrics)
  alarm_name          = "${var.metrics[count.index]}_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metrics[count.index]
  namespace           = var.metric_namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  treat_missing_data  = "notBreaching"
  alarm_description   = "Alarm of ${var.metrics[count.index]}"
  alarm_actions       = var.fail_actions
  ok_actions          = var.ok_actions
}
