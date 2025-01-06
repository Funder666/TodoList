/**
 * 任务列表页面
 **/

import { TaskHelper } from '../helper/TaskHelper'
import { TaskModel } from '../model/TaskModel'
import { promptAction } from '@kit.ArkUI'


@Preview
@Component
export struct ListPage {
  //显示添加页面的布尔值
  @Link displayAddPage: boolean
  @Link displayThemesPage: boolean
  @Link displaySummaryPage: boolean
  //任务列表
  @Link taskList: Array<TaskModel>
  //任务类型 默认为全部
  @State taskType: string = 'all'
  //总任务数量
  @Link totalTask: number
  //己完成任务数量
  @Link finishTask: number
  @State textContent: string = ''
  @State textTime: string = ''
  @Link bgColor: string
  // 当前编辑的任务ID
  @State currentTaskId: number | null = null

  aboutToAppear(): void {
    this.taskList=TaskHelper.readTaskList()
  }

  aboutToDisappear() {
    this.dialogController = null
  }

  exitApp() {
    console.info('单击空白区域中的回调')
  }

  //构建函数
  build() {
    Column({ space: 10 }) {
      Stack() {
        // 标题
        Text($r('app.string.my_task'))
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
        // 主题按钮
        Column() {
          Image($r('app.media.ic_public_themes'))
            .width(30)
            .fillColor(Color.Black)
            .onClick(() => {
              this.displayThemesPage = true
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.End)

      }
      .margin({ bottom: 10 })

      //三个按钮可选项
      Row() {
        Column() {
          Text($r('app.string.all'))
            .fontSize(20)
          // 单选框，组为taskType
          Radio({ value: 'all', group: 'taskType' })
            .onChange((isSelect) => {
              if (isSelect) {
                // 任务类型设置为all
                this.taskType = 'all'
              }
            })// 设置是否被选中
            .checked(this.taskType == 'all' ? true : false)
        }

        Column() {
          Text($r('app.string.todo'))
            .fontSize(20)
          Radio({ value: 'todo', group: 'taskType' })
            .onChange((isSelect) => {
              if (isSelect) {
                this.taskType = 'todo'
              }
            })
            .checked(this.taskType == 'todo' ? true : false)
        }

        Column() {
          Text($r('app.string.finish'))
            .fontSize(20)
          Radio({ value: 'finish', group: 'taskType' })
            .onChange((isSelect) => {
              if (isSelect) {
                this.taskType = 'finish'
              }
            })
            .checked(this.taskType == 'finish' ? true : false)
        }
      }
      .width('95%')
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor('#5Fffffff')
      .borderRadius(15)
      .padding(15)
      .border({ width: 5, color: '#5Fffffff' })

      // 任务进度卡片
      Row() {
        Text($r('app.string.task_progress'))
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Stack() {
          Progress({
            value: this.finishTask,
            total: this.totalTask,
            type: ProgressType.Ring
          })
            .width(70)

          Row() {
            Text(this.finishTask.toString())
              .fontSize(20)
              .fontColor($r('app.color.button_background'))
            Text('/ ' + this.totalTask.toString())
              .fontSize(20)
          }
        }

      }
      .card()
      .backgroundColor(Color.White)
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)

      Stack() {
        //显示任务
        Column({ space: 10 }) {
          // 如果任务列表为空，则显示提示信息
          if (this.taskList.length == 0) {
            Text($r('app.string.no_task'))
              .height('50%')
              .fontSize(28)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 15, bottom: 150 })
          } else {
            List({ space: 10 }) {
              ForEach(
                this.getTaskList(),
                (item: TaskModel, index) => {
                  ListItem() {
                    Row() {
                      //完成待办后的样式
                      Text(item.taskContent)// 设置左边距
                        .fontSize(20)// 设置字体大小
                        .margin({ left: 10 })// 根据任务是否完成，设置文本的样式
                        .decoration({
                          type: item.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None
                        })// 设置宽度
                        .width('70%')// 设置行数
                        .maxLines(1)// 设置文本溢出时的样式
                        .textOverflow({ overflow: TextOverflow.MARQUEE })
                      // 添加一个空行
                      Blank()
                      // 创建复选框
                      Checkbox()// 设置复选框的值
                        .select(item.isCompleted)// 当复选框的值发生变化时，执行回调函数
                        .onChange((value) => {
                          // 获取任务id在任务列表中的索引
                          let taskIndex = TaskHelper.getIndexByTaskId(this.taskList, item.taskId)
                          // 获取任务列表中对应任务id的任务
                          let oldTask = this.taskList[taskIndex]
                          // 创建新的任务模型
                          let newTask = new TaskModel(
                            item.taskId,
                            oldTask.taskContent,
                            oldTask.taskColor,
                            value,
                            oldTask.taskTime,
                            oldTask.bgColor
                          )
                          // 将新的任务模型替换任务列表中对应任务id的任务
                          this.taskList[taskIndex] = newTask

                          // 更新任务状态
                          item.isCompleted = value
                          // 更新任务数量
                          this.handleTaskChange()
                        })
                    }
                    .card()
                    .backgroundColor(item.taskColor)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .onClick(() => {
                      console.log("触发最外层点击事件")
                      this.textContent = item.taskContent
                      this.textTime = item.taskTime
                      this.currentTaskId=item.taskId
                      //展示详情弹窗
                      if (this.dialogController != null) {
                        this.dialogController.open()
                      }
                    })
                  }
                  .swipeAction({ end: this.deleteButton(item.taskId) })
                }
              )
            }
            .width('100%')
            .height('70%')
            .alignListItem(ListItemAlign.Center)
            .scrollBarColor(Color.Transparent)
          }

        }
        .margin({ top: 5, bottom: 5 })

        //新增任务按钮
        Column() {
          Button({
            // 设置按钮类型
            type: ButtonType.Circle,
            // 设置按钮状态
            stateEffect: true
          }) {
            Text('+')
              .fontSize(50)
              .fontColor(Color.White)
          }
          .width(60)
          .height(60)
          .borderColor($r('app.color.button_background'))
          .onClick(() => {
            // 显示添加页面
            this.displayAddPage = true
            this.handleTaskChange()
          })
        }
        // .width('100%')
        // .margin({ top: 130 })
        .alignItems(HorizontalAlign.End)
        .position({ bottom: 100, right: 10 })  // 定位到右下角

        //调用AI按钮
        Column() {
          Button({
            // 设置按钮类型
            type: ButtonType.Circle,
            // 设置按钮状态
            stateEffect: true
          }) {
            Text('AI')
              .fontSize(50)
              .fontColor(Color.White)
          }
          .width(60)
          .height(60)
          .borderColor($r('app.color.button_background'))
          .onClick(() => {
            // 显示AI页面
            this.displaySummaryPage = true
            this.handleTaskChange()
          })
        }
        // .width('100%')
        // .margin({ top: 130 })
        .alignItems(HorizontalAlign.Start)
        .position({ bottom: 100, left: 10 })  // 定位到左下角
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
    .padding({ top: 20, left: 20, right: 20, bottom: 20 })
  }

  // 处理任务更改
  handleTaskChange() {
    //1.更新任务总数量
    this.totalTask = this.taskList.length
    //2.更新已完成任务数量
    this.finishTask = this.taskList.filter(item => item.isCompleted).length

  }

  //获取任务列表
  getTaskList(): Array<TaskModel> {
    if (this.taskType == 'todo') {
      return this.taskList.filter((item) => {
        // 如果任务未完成，则返回true
        if (!item.isCompleted) {
          return true
        }
        return false
      })
      // 如果任务类型为finish，则返回已完成的任务列表
    } else if (this.taskType == 'finish') {
      return this.taskList.filter((item) => {
        // 如果任务已完成，则返回true
        if (item.isCompleted) {
          return true
        }
        return false;
      })
    }
    // 如果任务类型为all，则返回任务列表
    return this.taskList
    // 如果任务类型为todo，则返回未完成的任务列表
  }

  //删除弹窗提示函数
  deleteTask(taskId: number) {
    // 弹出提示框
    AlertDialog.show({
      title: $r('app.string.delete'),
      message: $r('app.string.sure_delete'),
      autoCancel: true,
      alignment: DialogAlignment.Bottom,
      // 偏移量
      offset: { dx: 0, dy: -30 },
      // 主要按钮
      primaryButton: {
        value: $r('app.string.no'),
        action: () => {
        }
      },
      // 次要按钮
      secondaryButton: {
        value: $r('app.string.yes'),
        action: () => {
          // 根据任务id获取任务索引
          let taskIndex = TaskHelper.getIndexByTaskId(this.taskList, taskId)
          // 从任务列表中删除任务
          this.taskList.splice(taskIndex, 1)
          this.handleTaskChange()
        }
      }
    })

  }

  @Builder
  deleteButton(taskId: number) {
    //删除按钮
    Button() {
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.deleteTask(taskId)
    })
  }

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogShow({
      textContent: $textContent,
      textTime: $textTime,
      taskList: $taskList,
      currentTaskId: $currentTaskId
    }),
    cancel: this.exitApp,
    autoCancel: true,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 10,
  })


}

//统一的卡片样式
@Styles
function card() {
  .width('95%')
  .padding(20)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

// 任务完成样式
@Extend(Text)
function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B2B1')
}

@CustomDialog
struct CustomDialogShow {
  @Link textContent: string
  @Link textTime: string
  @Link taskList:Array<TaskModel>
  @Link currentTaskId: number | null
  controller?: CustomDialogController
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogModify({
      textContent: $textContent,
      textTime: $textTime,
      taskList: $taskList,
      currentTaskId: $currentTaskId
    }),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -25 }
  })

  build() {
    Column() {
      Text($r('app.string.task_content'))
        .fontSize(15)
        .margin({ top: 10, bottom: 10 })
      Text(this.textContent)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 10 })
      Text($r('app.string.create_time'))
        .fontSize(15)
        .margin({ top: 10, bottom: 10 })
      Text(this.textTime)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 10 })

      Button($r('app.string.click_modify'))
        .onClick(() => {
          if (this.dialogController != null) {
            console.log("触发第二层点击事件")
            this.dialogController.open()
          }
        })
        .margin(20)
    }.borderRadius(10)
    .card()
  }
}

@CustomDialog
struct CustomDialogModify {
  controllerTwo?: CustomDialogController
  @Link textContent: string
  @Link textTime: string
  @Link taskList:Array<TaskModel>
  @Link currentTaskId: number | null
  build() {
    Column() {
      Text($r('app.string.change_text')).fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '', text: this.textContent }).height(60).width('90%')
        .onChange((value: string) => {
          this.textContent = value
        })
      Text($r('app.string.sure_change_text')).fontSize(16).margin({ bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button($r('app.string.cancel'))
          .onClick(() => {
            if (this.controllerTwo != undefined) {
              this.controllerTwo.close()
              console.info('cancel')
              promptAction.showToast({
                message: $r('app.string.cancel_changes')
              })
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button($r('app.string.confirm'))
          .onClick(() => {
            if (this.controllerTwo != undefined) {
              console.log("触发第三层点击事件")
              //更新当前任务的内容（使得最外层任务列表中的当前任务内容能够更新）
              if (this.currentTaskId != null) {
                let taskIndex = TaskHelper.getIndexByTaskId(this.taskList, this.currentTaskId)
                if (taskIndex !== -1) {
                  // 更新任务内容
                  this.taskList[taskIndex].taskContent = this.textContent
                  // 保存更新后的任务列表
                  TaskHelper.saveTaskList(this.taskList)
                }
              }
              this.controllerTwo.close()
              this.taskList=TaskHelper.readTaskList()
              promptAction.showToast({
                message: $r('app.string.change_succeeded')
              })
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }

}

