import { Handler, SQSEvent } from 'aws-lambda'
import { CloudWatchAlarmMessage, SQSNotificationRecord } from './aws.type'
import * as axios from 'axios'
import { SlackService } from './slack.service'
import { Alarm, AlarmMessages } from './notification.service'

const axiosInsance: axios.AxiosInstance = axios.default.create()

export const handler: Handler = async (event: SQSEvent): Promise<void> => {
  const alarmMessages: AlarmMessages = {
    error_on_main_count_alarm: {
      title: 'Alarm',
      alertMessage: 'Something went wrong on main service :fire:',
      okMessage: 'Main service is back to normal :ok_hand:'
    }
  }
  const slackService = new SlackService(axiosInsance, alarmMessages, process.env.SLACK_WEBHOOK_URL as string)
  const messages: CloudWatchAlarmMessage[] = event.Records
    .map(record => JSON.parse(record.body) as SQSNotificationRecord)
    .map(record => {
      return JSON.parse(record.Message) as CloudWatchAlarmMessage
    })
  for (const message of messages) {
    console.info('Message: ', message)
    const alarm: Alarm = {
      name: message.AlarmName,
      threshold: message.Trigger.Threshold,
      period: message.Trigger.Period
    }
    if (message.NewStateValue === 'ALARM') {
      await slackService.sendAlarmMessage(alarm)
    } else if (message.NewStateValue === 'OK') {
      await slackService.sendOkMessage(alarm)
    }
  }
}
