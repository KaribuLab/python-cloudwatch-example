interface AlarmMessage {
  title: string
  alertMessage: string
  okMessage: string
}

export interface AlarmMessages {
  [key: string]: AlarmMessage
}

export interface Alarm {
  threshold: number
  period: number
  name: string
}

export abstract class NotificationService {
  protected readonly _alarmMessage: AlarmMessages
  constructor (alarmMessage: AlarmMessages) {
    this._alarmMessage = alarmMessage
  }

  public abstract sendAlarmMessage (alarm: Alarm): Promise<void>
  public abstract sendOkMessage (alarm: Alarm): Promise<void>
}
