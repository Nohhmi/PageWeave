import { router } from '@kit.ArkUI';

@Entry
@Component
export struct ComposeEmail {
  @State toRecipient: string = '';
  @State subject: string = '';
  @State bodyContent: string = '';
  @State isSendEnabled: boolean = false;
  @State showCcBcc: boolean = false;
  @State ccRecipient: string = '';
  @State bccRecipient: string = '';

  aboutToAppear(): void {
    this.isSendEnabled = false;
  }

  onToRecipientChange(value: string): void {
    this.toRecipient = value;
    this.isSendEnabled = value.trim().length > 0;
  }

  build() {
    Column() {
      // ===== 顶部导航栏 =====
      Row() {
        Text('取消')
          .fontSize(17)
          .fontColor('#007AFF')
          .padding({ left: 8, right: 8 })
          .onClick(() => {
            router.back();
          })

        Blank()

        Text('写邮件')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()

        Text('发送')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isSendEnabled ? '#007AFF' : '#B3D4FF')
          .padding({ left: 8, right: 8 })
          .onClick(() => {
            if (this.isSendEnabled) {
              console.info('发送邮件');
              router.back();
            }
          })
      }
      .width('100%')
      .height(44)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#F8F8F8')
      .border({ width: { bottom: 0.5 }, color: '#C8C8C8' })

      // ===== 表单区域 =====
      Column() {
        // 收件人字段（聚焦状态）
        Row() {
          Text('收件人:')
            .fontSize(15)
            .fontColor('#000000')
            .width(60)
            .flexShrink(0)

          TextInput({ text: this.toRecipient, placeholder: '' })
            .fontSize(15)
            .fontColor('#000000')
            .placeholderColor('#C7C7CD')
            .backgroundColor(Color.Transparent)
            .border({ width: 0 })
            .layoutWeight(1)
            .defaultFocus(true)
            .onChange((value: string) => {
              this.onToRecipientChange(value);
            })

          Text('抄送 / 密送')
            .fontSize(13)
            .fontColor('#007AFF')
            .flexShrink(0)
            .padding({ left: 4, right: 4 })
            .onClick(() => {
              this.showCcBcc = !this.showCcBcc;
            })

          Text('+')
            .fontSize(20)
            .fontColor('#007AFF')
            .fontWeight(FontWeight.Lighter)
            .width(28)
            .height(28)
            .textAlign(TextAlign.Center)
            .borderRadius(14)
            .backgroundColor('#E8F0FE')
            .flexShrink(0)
            .margin({ left: 4 })
            .onClick(() => {
              console.info('打开联系人选择器');
            })
        }
        .width('100%')
        .padding({ left: 16, right: 12, top: 10, bottom: 10 })

        Divider()
          .strokeWidth(0.5)
          .color('#E0E0E0')
          .margin({ left: 16 })

        // 抄送字段（可展开）
        if (this.showCcBcc) {
          Row() {
            Text('抄送:')
              .fontSize(15)
              .fontColor('#000000')
              .width(60)
              .flexShrink(0)

            TextInput({ text: this.ccRecipient, placeholder: '' })
              .fontSize(15)
              .fontColor('#000000')
              .placeholderColor('#C7C7CD')
              .backgroundColor(Color.Transparent)
              .border({ width: 0 })
              .layoutWeight(1)
              .onChange((value: string) => {
                this.ccRecipient = value;
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })

          Divider()
            .strokeWidth(0.5)
            .color('#E0E0E0')
            .margin({ left: 16 })

          Row() {
            Text('密送:')
              .fontSize(15)
              .fontColor('#000000')
              .width(60)
              .flexShrink(0)

            TextInput({ text: this.bccRecipient, placeholder: '' })
              .fontSize(15)
              .fontColor('#000000')
              .placeholderColor('#C7C7CD')
              .backgroundColor(Color.Transparent)
              .border({ width: 0 })
              .layoutWeight(1)
              .onChange((value: string) => {
                this.bccRecipient = value;
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })

          Divider()
            .strokeWidth(0.5)
            .color('#E0E0E0')
            .margin({ left: 16 })
        }

        // 发件人字段（已填充）
        Row() {
          Text('发件人:')
            .fontSize(15)
            .fontColor('#000000')
            .width(60)
            .flexShrink(0)

          Text('蒋*9434@qq.com')
            .fontSize(15)
            .fontColor('#000000')
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })

        Divider()
          .strokeWidth(0.5)
          .color('#E0E0E0')
          .margin({ left: 16 })

        // 主题字段（空）
        Row() {
          Text('主题:')
            .fontSize(15)
            .fontColor('#000000')
            .width(60)
            .flexShrink(0)

          TextInput({ text: this.subject, placeholder: '' })
            .fontSize(15)
            .fontColor('#000000')
            .placeholderColor('#C7C7CD')
            .backgroundColor(Color.Transparent)
            .border({ width: 0 })
            .layoutWeight(1)
            .onChange((value: string) => {
              this.subject = value;
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 0.5 }, color: '#C8C8C8' })

      // ===== 正文编辑区 =====
      Scroll() {
        Column() {
          TextArea({ text: this.bodyContent, placeholder: '' })
            .fontSize(15)
            .fontColor('#000000')
            .placeholderColor('#C7C7CD')
            .backgroundColor(Color.Transparent)
            .border({ width: 0 })
            .width('100%')
            .constraintSize({ minHeight: 200 })
            .padding({ left: 16, right: 16, top: 12, bottom: 8 })
            .onChange((value: string) => {
              this.bodyContent = value;
            })

          Text('发自我的iPhone')
            .fontSize(13)
            .fontColor('#8E8E93')
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 12 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .scrollBar(BarState.Off)

      // ===== 底部快捷工具栏 =====
      Row() {
        // 附件按钮（红点徽章）
        Stack() {
          Text('📎')
            .fontSize(24)

          Circle()
            .width(8)
            .height(8)
            .fill('#FF3B30')
            .position({ x: 18, y: -2 })
        }
        .width(44)
        .height(44)
        .onClick(() => {
          console.info('打开附件选择器');
        })

        Blank()

        // 邮件按钮
        Text('✉️')
          .fontSize(24)
          .onClick(() => {
            console.info('邮件按钮点击');
          })

        Blank()

        // 定时发送按钮
        Image($r('sys.media.ohos_ic_public_clock'))
          .width(24)
          .height(24)
          .fillColor('#007AFF')
          .onClick(() => {
            console.info('定时发送按钮点击');
          })
      }
      .width('100%')
      .height(44)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#F8F8F8')
      .border({ width: { top: 0.5 }, color: '#C8C8C8' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }
}

