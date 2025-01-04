/**
 * 新增任务的页面
 */
import systemDateTime from '@ohos.systemDateTime'
import promptAction from '@ohos.promptAction'
import { TaskModel } from '../model/TaskModel'


@Preview
@Component
export struct AddPage {
  // 是否显示添加任务页面
  @Link displayAddPage: boolean
  //任务id
  @State taskId: number = new Date().getTime()
  // 用户输入的任务内容
  @State taskContent: string = ''
  // 任务颜色
  @State taskColor: string = '#FFFFFF'
  // 任务时间
  @State taskTime: string = this.getCurrentTime24HourFormat()
  // 任务列表
  @Link taskList: Array<TaskModel>
  //总任务数量
  @Link totalTask: number
  //已完成任务数量
  @Link finishTask: number
  @Link bgColor: string

  build() {
    Column({ space: 20 }) {
      Stack() {
        // 返回按钮
        Column() {
          Image($r('app.media.ic_public_back'))
            .width(30)
            .fillColor(Color.Black)
            .onClick(() => {
              this.displayAddPage = false;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // 标题
        Text($r('app.string.Add_task'))
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
      }

      //用户自定义任务名
      TextArea({ text: this.taskContent, placeholder: $r('app.string.enter_task_content') })
        .backgroundColor(Color.White)
        .placeholderFont({ size: 18 })
        .width('95%')
        .height('25%')
        .fontSize(20)
        .borderRadius(9)
        .maxLength(150)
        .copyOption(CopyOptions.None)
        .borderColor(Color.Gray)
        .onChange((value) => {
          this.taskContent = value;
        })

      // 任务颜色
      Row({ space: 10 }) {
        Column({ space: 5 }) {
          Text() {
            Span($r('app.string.importance'))
          }
          .fontSize(19)
        }
        .width('40%')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 5 }) {
          Row({ space: 10 }) {
            // 红色
            Column() {
              Radio({ value: 'Red', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_red'),
                  indicatorColor: $r('app.color.button_red'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#ff8280'
                  }
                  promptAction.showToast({
                    message: $r('app.string.red'),
                  })
                })
                .checked(this.taskColor == '#ff8280' ? true : false)
            }

            // 橙色
            Column() {
              Radio({ value: 'Orange', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_orange'),
                  indicatorColor: $r('app.color.button_orange'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#ffb978'
                  }
                  promptAction.showToast({
                    message: $r('app.string.orange'),
                  })
                })
                .checked(this.taskColor == '#ffb978' ? true : false)
            }

            // 黄色
            Column() {
              Radio({ value: 'Yellow', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_yellow'),
                  indicatorColor: $r('app.color.button_yellow'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#f0eb6e'
                  }
                  promptAction.showToast({
                    message: $r('app.string.yellow'),
                  })
                })
                .checked(this.taskColor == '#f0eb6e' ? true : false)
            }

            // 绿色
            Column() {
              Radio({ value: 'Green', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_green'),
                  indicatorColor: $r('app.color.button_green'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#85ff85'
                  }
                  promptAction.showToast({
                    message: $r('app.string.green'),
                  })
                })
                .checked(this.taskColor == '#85ff85' ? true : false)
            }
          }

          Row({ space: 10 }) {
            // 青色
            Column() {
              Radio({ value: 'Cyan', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_cyan'),
                  indicatorColor: $r('app.color.button_cyan'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#89f1f5'
                  }
                  promptAction.showToast({
                    message: $r('app.string.cyan'),
                  })
                })
                .checked(this.taskColor == '#89f1f5' ? true : false)
            }

            // 蓝色
            Column() {
              Radio({ value: 'Blue', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_blue'),
                  indicatorColor: $r('app.color.button_blue'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#8c9dff'
                  }
                  promptAction.showToast({
                    message: $r('app.string.blue'),
                  })
                })
                .checked(this.taskColor == '#8c9dff' ? true : false)
            }

            //紫色
            Column() {
              Radio({ value: 'Purple', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: $r('app.color.button_purple'),
                  indicatorColor: $r('app.color.button_purple'),
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#c39cff'
                  }
                  promptAction.showToast({
                    message: $r('app.string.purple'),
                  })
                })
                .checked(this.taskColor == '#c39cff' ? true : false)
            }

            // 白色
            Column() {
              Radio({ value: 'White', group: 'taskColor' })
                .radioStyle({
                  checkedBackgroundColor: Color.White,
                  indicatorColor: Color.White
                })
                .onChange((isSelect) => {
                  if (isSelect) {
                    this.taskColor = '#FFFFFF'
                  }
                  promptAction.showToast({
                    message: $r('app.string.white'),
                  })
                })
                .checked(this.taskColor == '#FFFFFF' ? true : false)
            }
          }
        }
      }
      .backgroundColor('#5Fffffff')
      .borderRadius(15)
      .padding(15)
      .border({ width: 5, color: '#5Fffffff' })

      //提交按钮
      Button({
        stateEffect: true,
        type: ButtonType.Normal
      }) {
        Text($r('app.string.submit'))
          .fontColor(Color.White)
      }
      .width(315)
      .height(50)
      .borderRadius(5)
      .borderColor($r('app.color.button_background'))
      // 当输入框内容发生变化时触发该函数
      .onClick(() => {
        // 判断输入框内容是否为空
        if (this.taskContent.length === 0) {
          try {
            // 显示提示信息
            promptAction.showToast({
              message: $r('app.string.not_empty'),
              duration: 2000,
            })
          } catch (error) {
            console.error(`showToast args error code is ${error.code}, message is ${error.message}`);
          }
          return
        }
        // 获取当前时间
        systemDateTime.getCurrentTime(true).then(() => {
          // 创建一个新的任务模型
          let task = new TaskModel(
            // 任务ID为当前时间
            this.taskId,
            // 任务内容为输入框内容
            this.taskContent,
            // 任务颜色
            this.taskColor,
            // 任务状态初始化为未完成
            false,
            // 任务创建时间为当前时间
            this.taskTime,
            this.bgColor
          )
          // 将新任务添加到任务列表中
          this.taskList.push(task)
          // 更新任务总数量
          this.totalTask = this.taskList.length
          // 隐藏添加任务页面
          this.displayAddPage = false
          console.info(`id : ${task.taskId}`)
          console.info(`content : ${task.taskContent}`)
          console.info(`color : ${task.taskColor}`)
          console.info(`isCompleted : ${task.isCompleted}`)
          console.info(`taskTime : ${task.taskTime}`)
        })

        console.info(`taskList is ${this.taskList}`)
        //输出任务的信息
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
    .padding({ top: 30, left: 20, right: 20, bottom: 20 })
  }

  getCurrentTime24HourFormat(): string {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    return `${year}/${month}/${day}  ${hours}:${minutes}:${seconds}`;
  }
}