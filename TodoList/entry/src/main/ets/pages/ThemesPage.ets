/**
 * 主题换肤页
 */
import { promptAction } from '@kit.ArkUI'

@Preview
@Component
export struct ThemesPage {
  @Link bgColor: string
  @State selectedColor: string = ''
  @Link displayThemesPage: boolean

  build() {
    Column({ space: 20 }) {
      Row() {
        // 返回按钮
        Image($r('app.media.ic_public_back'))
          .width(30)
          .fillColor(Color.Black)
          .onClick(() => {
            this.displayThemesPage = false
          })

        // 标题
        Text($r('app.string.change_theme'))
          .fontSize(23)
          .width('80%')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

        // 确认按钮
        Image($r('app.media.ic_public_todo'))
          .width(30)
          .fillColor(Color.Black)
          .onClick(() => {
            // 弹出提示框
            this.confirmDialog()
          })
      }
      .width('100%')

      Row({ space: 20 }) {
        //默认
        Column() {
          Text($r('app.string.default'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#BCCEDA')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.default'),
          })
          this.selectedColor = '#BCCEDA'
        })

        //粉色
        Column() {
          Text($r('app.string.pink'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#FFBFCD')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.pink'),
          })
          this.selectedColor = '#FFBFCD'
        })

      }

      Row({ space: 20 }) {
        //灰色
        Column() {
          Text($r('app.string.grey'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#808080')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.grey'),
          })
          this.selectedColor = '#808080'
        })

        // 橙色
        Column() {
          Text($r('app.string.orange'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#FFE5A7')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.orange'),
          })
          this.selectedColor = '#FFE5A7'
        })
      }

      Row({ space: 20 }) {
        //绿色
        Column() {
          Text($r('app.string.green'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#a8bf8f')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.green'),
          })
          this.selectedColor = '#a8bf8f'
        })

        // 蓝色
        Column() {
          Text($r('app.string.blue'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#95C8E2')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.blue'),
          })
          this.selectedColor = '#95C8E2'
        })

      }

      Row({ space: 20 }) {
        // 紫色
        Column() {
          Text($r('app.string.purple'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)
        }
        .backgroundColor('#dcc7e1')
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.purple'),
          })
          this.selectedColor = '#dcc7e1'
        })


        // 更多
        Column() {
          Text($r('app.string.more'))
            .fontColor(Color.White)
            .TextStyle()
            .textAlign(TextAlign.Center)

          Text('?')
            .fontSize(50)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .margin({ top: 30 })
        }
        .Item()
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.more'),
          })
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
    .padding({
      top: 30,
      left: 20,
      right: 20,
      bottom: 20
    })
  }

  //确认弹窗提示函数

  confirmDialog() {
    AlertDialog.show({
      title: $r('app.string.prompt'),
      message: $r('app.string.sure_change_theme'),
      autoCancel: true,
      alignment: DialogAlignment.Center,
      // 偏移量
      offset: { dx: 0, dy: -30 },
      // 主要按钮
      primaryButton: {
        value: $r('app.string.cancel'),
        action: () => {
        }
      },
      // 次要按钮
      secondaryButton: {
        value: $r('app.string.confirm'),
        action: () => {
          this.bgColor = this.selectedColor
        }
      }
    })
  }
}

@Styles
function Item() {
  .width('45%')
  .height('20%')
  .border({ width: 5, color: Color.White, radius: 20 })

}

@Styles
function TextStyle() {
  .width('100%')
  .height('15%')
  .backgroundColor('#3F000000')
  .align(Alignment.Bottom)
}