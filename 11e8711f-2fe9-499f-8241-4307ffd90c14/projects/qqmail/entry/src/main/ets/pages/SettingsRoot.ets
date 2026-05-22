import { router } from '@kit.ArkUI';

@Entry
@Component
export struct SettingsRoot {
  build() {
    Column() {
      // Header bar
      Row() {
        Text('关闭')
          .fontSize(16)
          .fontColor('#007AFF')
          .onClick(() => {
            router.back();
          })
        Blank()
        Text('设置')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Blank()
        // Right spacer to balance the layout (same width as "关闭")
        Row()
          .width(48)
          .height(44)
      }
      .width('100%')
      .height(44)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column() {
          // Account section
          Column() {
            // Account item row
            Row() {
              // Avatar
              Circle()
                .width(48)
                .height(48)
                .fill('#E8E0F0')

              // User info
              Column() {
                Text('蒋')
                  .fontSize(17)
                  .fontColor('#000000')
                  .fontWeight(FontWeight.Medium)
                Text('1434@qq.com')
                  .fontSize(13)
                  .fontColor('#888888')
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
              .layoutWeight(1)

              // Upgrade tag
              Text('升级')
                .fontSize(12)
                .fontColor('#9B59B6')
                .border({
                  width: 1,
                  color: '#9B59B6',
                  radius: 4
                })
                .padding({ left: 8, right: 8, top: 2, bottom: 2 })

              // Chevron
              Text('>')
                .fontSize(16)
                .fontColor('#C7C7CC')
                .margin({ left: 8 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .alignItems(VerticalAlign.Center)

            // Separator
            Divider()
              .color('#E0E0E0')
              .margin({ left: 76 })

            // Add account row
            Row() {
              // Plus icon
              Text('+')
                .fontSize(20)
                .fontColor('#007AFF')
                .width(48)
                .height(48)
                .textAlign(TextAlign.Center)

              Text('添加账号')
                .fontSize(17)
                .fontColor('#000000')
                .margin({ left: 12 })
                .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#C7C7CC')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 4, bottom: 4 })
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(0)

          // Spacing between sections
          Column()
            .width('100%')
            .height(32)

          // Section: 新邮件提醒
          Column() {
            // Section header
            Text('新邮件提醒')
              .fontSize(13)
              .fontColor('#888888')
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .width('100%')

            // List items
            this.SettingsListItem('通用', () => {
              router.pushUrl({ url: 'pages/GeneralSettings' });
            })

            Divider()
              .color('#E0E0E0')
              .margin({ left: 16 })

            this.SettingsListItem('邮件', () => {
              router.pushUrl({ url: 'pages/NotificationGuide' });
            })

            Divider()
              .color('#E0E0E0')
              .margin({ left: 16 })

            this.SettingsListItem('储存', () => {
              // Target page not in current page set
              console.info('储存 settings page not available');
            })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // Spacing between sections
          Column()
            .width('100%')
            .height(32)

          // Section: 个人信息与权限
          Column() {
            // Section header
            Text('个人信息与权限')
              .fontSize(13)
              .fontColor('#888888')
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .width('100%')

            this.SettingsListItem('个人信息收集清单', () => {
              console.info('个人信息收集清单 page not available');
            })

            Divider()
              .color('#E0E0E0')
              .margin({ left: 16 })

            this.SettingsListItem('第三方共享个人信息清单', () => {
              console.info('第三方共享个人信息清单 page not available');
            })

            Divider()
              .color('#E0E0E0')
              .margin({ left: 16 })

            // 手势密码与面容识别 with status
            Row() {
              Text('手势密码与面容识别')
                .fontSize(17)
                .fontColor('#000000')
                .layoutWeight(1)

              Text('关闭')
                .fontSize(15)
                .fontColor('#888888')
                .margin({ right: 8 })

              Text('>')
                .fontSize(16)
                .fontColor('#C7C7CC')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .alignItems(VerticalAlign.Center)
            .onClick(() => {
              console.info('手势密码与面容识别 page not available');
            })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // Spacing between sections
          Column()
            .width('100%')
            .height(32)

          // Section: 帮助与反馈
          Column() {
            // Section header
            Text('帮助与反馈')
              .fontSize(13)
              .fontColor('#888888')
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .width('100%')

            this.SettingsListItem('关于', () => {
              console.info('关于 page not available');
            })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  SettingsListItem(label: string, onClick: () => void) {
    Row() {
      Text(label)
        .fontSize(17)
        .fontColor('#000000')
        .layoutWeight(1)

      Text('>')
        .fontSize(16)
        .fontColor('#C7C7CC')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
    .onClick(onClick)
  }
}
