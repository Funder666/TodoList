/**
 * 调用AI的页面
 */
import { TaskModel } from '../model/TaskModel'
import {LLM} from '../helper/AIHelper'

@Preview
@Component
export struct AIPage {
  // 是否显示添加任务页面
  @Link displayAIPage: boolean
  @Link finishTask: number
  //任务类型 默认为全部
  @Link displaySummaryPage:boolean
  //总任务数量
  @Link totalTask: number
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
      //
      Row() {
        Text($r('app.string.ai_summary'))
          .fontSize(28)
          .fontWeight(FontWeight.Bold)



      }
      .card()
      .backgroundColor(Color.White)
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .onClick(() => {

        this.displayAIPage = false
        this.displaySummaryPage = true

      })



      }
      .backgroundColor(this.bgColor)
      .borderRadius(15)
      .padding({ top: 30, left: 20, right: 20, bottom: 20 })
      .border({ width: 5, color: '#5Fffffff' })
      .width('100%')
      .height('100%')


  }

}
@Styles
function card() {
  .width('95%')
  .padding(20)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}