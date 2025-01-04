/**
 * 入场动画
 */
import router from '@ohos.router'
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
export struct EnterPage {
  @State isVisibility: boolean = false;

  build() {
    Row() {
      Column({ space: 50 }) {
        // logo
        Row() {
          Image($r('app.media.logo'))
            .width(100)
            .height(100)
        }
        .margin({ top: 30 })

        // welcome
        Column({ space: 20 }) {
          Text($r('app.string.welcome'))
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontStyle(FontStyle.Italic)
          Text($r('app.string.advertisement'))
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontStyle(FontStyle.Italic)
        }

        // button
        Row() {
          Button('👉', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(25)
            .borderRadius(20)
            .backgroundColor($r('app.color.button_background'))
            .width(70)
            .height(70)
            .onClick(() => {
              this.showDialog()
            })
        }

        // loading
        if (this.isVisibility) {
          LoadingProgress()
            .width(50)
            .height(50)
        } else {
          Text()
            .width(50)
            .height(50)
        }
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#F6F6F6')
  }

  //显示对话框
  showDialog() {
    AlertDialog.show({
      title: ('服务协议和隐私政策'),
      message: ('请你务必审慎阅读、充分理解服务协议”和“隐私政策”各条款，包括但不限于：为了向您提供待办提醒等服务，我们需要向您的系统日历添加待办内容。你可以在系统设置中管理对应权限。你可阅读《服务协议》和《隐私政策》了解详细信息。如同意请点击“同意”开始接受我们的服务。'),
      autoCancel: true,
      alignment: DialogAlignment.Center,
      // 偏移量
      offset: { dx: 0, dy: -30 },
      // 主要按钮
      primaryButton: {
        value: ('拒绝'),
        action: () => {
          router.back()
        }
      },
      // 次要按钮
      secondaryButton: {
        value: ('同意'),
        action: () => {
          this.isVisibility = true
          promptAction.showToast({
            message: $r('app.string.welcome'),
          })
          // 延时跳转页面
          setTimeout(() => {
            router.replaceUrl({
              url: 'pages/MainPage',
            })
          }, 2000)
        }
      }
    })
  }
}