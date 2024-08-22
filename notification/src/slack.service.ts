import * as axios from 'axios'
import { Alarm, AlarmMessages, NotificationService } from './notification.service'

export class SlackService extends NotificationService {
  private readonly _webhookUrl: string
  private readonly _axios: axios.AxiosInstance
  constructor (axios: axios.AxiosInstance, alarmMessage: AlarmMessages, webhookUrl: string) {
    super(alarmMessage)
    this._webhookUrl = webhookUrl
    this._axios = axios
  }

  public async sendAlarmMessage (alarm: Alarm): Promise<void> {
    console.info(`Sending alarm message to Slack: ${alarm.name}`)
    const { alertMessage, title } = this._alarmMessage[alarm.name]
    const payload = {
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: title
          }
        },
        {
          type: 'divider'
        },
        {
          type: 'section',
          text: {
            text: alertMessage,
            type: 'mrkdwn'
          },
          fields: [
            {
              type: 'mrkdwn',
              text: '*Threshold*'
            },
            {
              type: 'mrkdwn',
              text: '*Seconds*'
            },
            {
              type: 'mrkdwn',
              text: `${alarm.threshold}`
            },
            {
              type: 'mrkdwn',
              text: `${alarm.period}`
            }
          ]
        }
      ]
    }
    await this._axios.post(this._webhookUrl, payload)
  }

  public async sendOkMessage (alarm: Alarm): Promise<void> {
    console.info(`Sending alarm message to Slack: ${alarm.name}`)
    const { okMessage, title } = this._alarmMessage[alarm.name]
    const payload = {
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: title
          }
        },
        {
          type: 'divider'
        },
        {
          type: 'section',
          text: {
            text: okMessage,
            type: 'mrkdwn'
          }
        }
      ]
    }
    await this._axios.post(this._webhookUrl, payload)
  }
}
