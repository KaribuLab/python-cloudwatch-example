export interface SQSNotificationRecord {
  Type: string
  MessageId: string
  TopicArn: string
  Message: string
  Timestamp: string
  SignatureVersion: string
  Signature: string
  SigningCertURL: string
  UnsubscribeURL: string
}

export interface CloudWatchAlarmMessage {
  AlarmName: string
  AlarmDescription: string
  AWSAccountId: string
  NewStateValue: 'OK' | 'ALARM' | 'INSUFFICIENT_DATA'
  NewStateReason: string
  StateChangeTime: string
  Region: string
  OldStateValue: string
  OKActions: string[]
  AlarmActions: string[]
  Trigger: CloudWatchAlarmTrigger
}

export interface CloudWatchAlarmTrigger {
  MetricName: string
  Namespace: string
  Statistic: string
  Unit: string
  Dimensions: CloudWatchAlarmDimension[]
  Period: number
  EvaluationPeriods: number
  ComparisonOperator: string
  Threshold: number
  TreatMissingData: string
  EvaluateLowSampleCountPercentile: string
}

export interface CloudWatchAlarmDimension {
  name: string
  value: string
}
