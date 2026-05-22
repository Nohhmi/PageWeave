import { router } from '@kit.ArkUI';

@Entry
@Component
export struct GeneralSettings {
  @State soundEnabled: boolean = true;
  @State avatarEnabled: boolean = true;

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

        Text('通用')
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

      // Scrollable section list
      Scroll() {
        Column() {
          // Section 1: 管理类
          Column() {
            // 首页管理
            Row() {
              Text('首页管理')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#C0C0C0')
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              console.info('首页管理 - 目标页不在当前页面集合中');
            })

            Divider()
              .strokeWidth(0.5)
              .color('#E8E8E8')
              .margin({ left: 16 })

            // 应用设置
            Row() {
              Text('应用设置')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#C0C0C0')
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              router.pushUrl({ url: 'pages/AppSettings' });
            })
          }
          .width('100%')
          .borderRadius(0)
          .margin({ top: 12 })

          // Section 2: 功能开关与偏好
          Column() {
            // 发信音效
            Row() {
              Text('发信音效')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Toggle({ type: ToggleType.Switch, isOn: this.soundEnabled })
                .onChange((isOn: boolean) => {
                  this.soundEnabled = isOn;
                })
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')

            Divider()
              .strokeWidth(0.5)
              .color('#E8E8E8')
              .margin({ left: 16 })

            // 邮件列表头像
            Row() {
              Text('邮件列表头像')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Toggle({ type: ToggleType.Switch, isOn: this.avatarEnabled })
                .onChange((isOn: boolean) => {
                  this.avatarEnabled = isOn;
                })
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')

            Divider()
              .strokeWidth(0.5)
              .color('#E8E8E8')
              .margin({ left: 16 })

            // 文字大小
            Row() {
              Text('文字大小')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Row({ space: 4 }) {
                Text('跟随系统')
                  .fontSize(14)
                  .fontColor('#999999')

                Text('>')
                  .fontSize(16)
                  .fontColor('#C0C0C0')
              }
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              console.info('文字大小 - 目标页不在当前页面集合中');
            })

            Divider()
              .strokeWidth(0.5)
              .color('#E8E8E8')
              .margin({ left: 16 })

            // 加载邮件图片
            Row() {
              Text('加载邮件图片')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Row({ space: 4 }) {
                Text('所有网络')
                  .fontSize(14)
                  .fontColor('#999999')

                Text('>')
                  .fontSize(16)
                  .fontColor('#C0C0C0')
              }
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              console.info('加载邮件图片 - 目标页不在当前页面集合中');
            })
          }
          .width('100%')
          .borderRadius(0)
          .margin({ top: 12 })

          // Section 3: 语言
          Column() {
            // 语言
            Row() {
              Text('语言')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#C0C0C0')
            }
            .width('100%')
            .height(44)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              console.info('语言 - 目标页不在当前页面集合中');
            })
          }
          .width('100%')
          .borderRadius(0)
          .margin({ top: 12 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
