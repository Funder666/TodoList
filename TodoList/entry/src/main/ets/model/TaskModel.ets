/**
 * 任务类
 */
export class TaskModel {
  // 任务id
  taskId: number = 0
  // 任务内容
  taskContent: string = ''
  // 任务颜色
  taskColor: string = ''
  // 任务是否完成
  isCompleted: boolean = false
  // 任务时间
  taskTime: string = ''
  //背景颜色
  bgColor: string = ''

  constructor(taskId: number, taskContent: string, taskColor: string, isCompleted: boolean, taskTime: string, bgColor: string) {
    this.taskId = taskId
    this.taskContent = taskContent
    this.taskColor = taskColor
    this.isCompleted = isCompleted
    this.taskTime = taskTime
    this.bgColor = bgColor
  }
}