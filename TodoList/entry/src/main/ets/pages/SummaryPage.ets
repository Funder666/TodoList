// xxx.ets

import { TaskModel } from '../model/TaskModel'
import { http } from '@kit.NetworkKit';
import {LLM} from '../helper/AIHelper'
import { TaskHelper } from '../helper/TaskHelper'
@Preview
@Component
export struct SummaryPage {
  @Link displaySummaryPage : boolean
  @Link taskList: Array<TaskModel>
  @Link bgColor : string
  @Link displayAIPage: boolean
  @State taskType: string = 'all'
  @State AIAnswer: string=""
  @State answer:string=""
  @State click:boolean=true
  @State tasks:string=""

  build() {
    Column({ space: 20 }) {
      Stack() {
        // 返回按钮
        Column() {
          Image($r('app.media.ic_public_back'))
            .width(30)
            .fillColor(Color.Black)
            .onClick(() => {
              this.displaySummaryPage=false

            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // 标题(AI总结)
        Text($r('app.string.ai_summary'))
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
      }

      Scroll(){//显示任务
      Column() {

        // 如果任务列表为空，则显示提示信息
        if (this.taskList.length == 0) {
          Text($r('app.string.no_task'))
            .height('50%')
            .fontSize(28)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 15, bottom: 150 })
        } else {
          Text("目前的工作有：")
          List() {

            ForEach(

              this.getTaskList(),
              (item: TaskModel, index) => {

                ListItem() {
                  Row() {
                    //完成待办后的样式
                    Text(item.taskContent)// 设置左边距
                      .fontSize(20)// 设置字体大小
                      .width('100%')// 设置行数
                  }
                }
              }
            )
          }
          .card()
          .backgroundColor("white")}
          //提交按钮
          if(this.click){
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
          .onClick(async () => {
            console.log("before")
            this.taskType='todo'
            let a=TaskHelper.getTaskContent(this.getTaskList())
            console.log("after")
            this.answer= await LLM.getHttpResult("根据以下设定的任务以不超过200个字做出总结与规划："+a)
            this.click=false
            //输出任务的信息
          })}
          Blank()
            .height("10")
          if(!this.click){
          Text("根据您已经设定的任务，我们得到：")
            Scroll(){
          Text(this.answer)
            .card()
            .backgroundColor("white")}}
        }
      }
}
    .backgroundColor(this.bgColor)
    .borderRadius(15)
    .padding({ top: 30, left: 20, right: 20, bottom: 20 })
    .border({ width: 5, color: '#5Fffffff' })
    .width('100%')
    .height('100%')
  }
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
}

@Styles
function card() {
  .width('95%')
  .padding(20)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}