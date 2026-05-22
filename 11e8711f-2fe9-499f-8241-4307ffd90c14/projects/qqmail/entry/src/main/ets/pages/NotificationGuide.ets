import { router } from '@kit.ArkUI';

@Entry
@Component
export struct NotificationGuide {
  @State toggleOn: boolean = false;

  build() {
    Column() {
      // Navigation bar
      Row() {
        Button() {
          Text('←')
            .fontSize(20)
            .fontColor('#333333')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(44)
        .height(44)
        .onClick(() => {
          router.back();
        })

        Text('新邮件提醒')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Right spacer to balance the back button
        Row()
          .width(44)
          .height(44)
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E0E0E0'
      })

      // Main content
      Scroll() {
        Column() {
          // Toggle row
          Row() {
            Text('新邮件提醒')
              .fontSize(16)
              .fontColor('#333333')
              .layoutWeight(1)

            Toggle({ type: ToggleType.Switch, isOn: this.toggleOn })
              .onChange((isOn: boolean) => {
                // Toggle is non-functional per design: notification settings
                // must be configured in iOS system settings, not in-app.
                // Keep visual state but do not persist or apply changes.
                this.toggleOn = isOn;
              })
          }
          .width('100%')
          .height(44)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')

          // Instruction text
          Text('更改通知样式，请在iPhone的"设置"-"通知"功能中，找到"QQ邮箱"程序进行修改。')
            .fontSize(13)
            .fontColor('#888888')
            .lineHeight(20)
            .padding({ left: 16, right: 16, top: 12 })
            .width('100%')
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
