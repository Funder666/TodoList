/**
 * 调用AI的页面
 */
import { TaskModel } from '../model/TaskModel'


@Preview
@Component
export struct AIPage {
  // 是否显示添加任务页面
  @Link displayAIPage: boolean

  // 任务列表
  @Link taskList: Array<TaskModel>


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
              this.displayAIPage = false;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // 标题(AI总结)
        Text($r('app.string.ai_summary'))
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
      }

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
        console.info(`taskList is ${this.taskList}`)
        //输出任务的信息
      })

      }
      .backgroundColor('#5Fffffff')
      .borderRadius(15)
      .padding(15)
      .border({ width: 5, color: '#5Fffffff' })



  }

}