import { router } from '@kit.ArkUI';

@Entry
@Component
export struct InvoiceSetup {
  @State isAgreementChecked: boolean = false;
  @State isAutoDetectChecked: boolean = true;

  build() {
    Column() {
      // ===== Navigation Bar =====
      Row() {
        // Back button
        Text('←')
          .fontSize(20)
          .fontColor('#333333')
          .padding({ left: 16, right: 8, top: 12, bottom: 12 })
          .onClick(() => {
            router.back();
          })

        // Title
        Text('文件云盘')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Placeholder for symmetry
        Row()
          .width(44)
          .height(44)
      }
      .width('100%')
      .height(48)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // ===== Scrollable Content =====
      Scroll() {
        Column() {
          // ===== Hero Section =====
          Column({ space: 16 }) {
            // Green invoice icon (envelope with invoice lines)
            Column() {
              // Envelope body
              Stack() {
                // Envelope shape
                Column()
                  .width(72)
                  .height(56)
                  .borderRadius(8)
                  .backgroundColor('#E8F5E9')
                  .border({ width: 2, color: '#4CAF50' })

                // Invoice lines on envelope
                Column({ space: 4 }) {
                  Row()
                    .width(32)
                    .height(4)
                    .borderRadius(2)
                    .backgroundColor('#4CAF50')
                  Row()
                    .width(24)
                    .height(4)
                    .borderRadius(2)
                    .backgroundColor('#4CAF50')
                  Row()
                    .width(28)
                    .height(4)
                    .borderRadius(2)
                    .backgroundColor('#4CAF50')
                }
              }

              // Decorative sparkle dots
              Row({ space: 4 }) {
                Circle({ width: 4, height: 4 })
                  .fill('#4CAF50')
                Circle({ width: 3, height: 3 })
                  .fill('#81C784')
                Circle({ width: 5, height: 5 })
                  .fill('#4CAF50')
              }
              .margin({ top: 8 })
            }
            .margin({ top: 40 })

            // Heading
            Text('开启并使用发票')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 32, bottom: 24 })

          // ===== Feature List Card =====
          Column({ space: 0 }) {
            // Feature 1: Auto sync with auto-detect sub-option
            Column() {
              Row({ space: 8 }) {
                // Bullet dot
                Circle({ width: 6, height: 6 })
                  .fill('#4CAF50')

                Text('邮件中的发票自动同步，一目了然')
                  .fontSize(15)
                  .fontColor('#333333')
                  .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Sub-item: auto detect checkbox
              Row({ space: 8 }) {
                Checkbox({ name: 'autoDetect', group: 'autoDetectGroup' })
                  .select(this.isAutoDetectChecked)
                  .selectedColor('#4CAF50')
                  .onChange((value: boolean) => {
                    this.isAutoDetectChecked = value;
                  })

                Text('自动识别下载发票邮件附件的发票')
                  .fontSize(13)
                  .fontColor('#666666')
              }
              .width('100%')
              .padding({ left: 14, top: 8 })
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding({ top: 16, bottom: 12, left: 16, right: 16 })

            Divider()
              .strokeWidth(0.5)
              .color('#EEEEEE')
              .margin({ left: 16, right: 16 })

            // Feature 2: WeChat invoice sync
            Row({ space: 8 }) {
              Circle({ width: 6, height: 6 })
                .fill('#4CAF50')

              Text('关联微信发票后，两端同步更便捷')
                .fontSize(15)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .padding({ top: 12, bottom: 12, left: 16, right: 16 })
            .alignItems(VerticalAlign.Center)

            Divider()
              .strokeWidth(0.5)
              .color('#EEEEEE')
              .margin({ left: 16, right: 16 })

            // Feature 3: One-click expense report
            Row({ space: 8 }) {
              Circle({ width: 6, height: 6 })
                .fill('#4CAF50')

              Text('一键生成报销单，发票批量省心管')
                .fontSize(15)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .padding({ top: 12, bottom: 16, left: 16, right: 16 })
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .margin({ left: 16, right: 16, top: 8 })

          // ===== Agreement Section =====
          Row({ space: 6 }) {
            Checkbox({ name: 'agreement', group: 'agreementGroup' })
              .select(this.isAgreementChecked)
              .selectedColor('#4CAF50')
              .onChange((value: boolean) => {
                this.isAgreementChecked = value;
              })

            Row() {
              Text('我已阅读并同意')
                .fontSize(13)
                .fontColor('#666666')

              Text('《腾讯邮箱发票授权须知》')
                .fontSize(13)
                .fontColor('#2196F3')
                .decoration({ type: TextDecorationType.Underline })
                .onClick(() => {
                  // Target page (authorization agreement detail) is not in current page set.
                  console.info('[InvoiceSetup] 协议链接被点击，目标授权协议详情页不在当前页面集合中');
                })
            }
          }
          .width('100%')
          .padding({ left: 20, right: 16, top: 20, bottom: 8 })
          .alignItems(VerticalAlign.Center)

          // ===== Confirm Button =====
          Button('确定')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isAgreementChecked ? '#FFFFFF' : '#B0BEC5')
            .backgroundColor(this.isAgreementChecked ? '#2196F3' : '#E0E0E0')
            .width('100%')
            .height(48)
            .borderRadius(24)
            .enabled(this.isAgreementChecked)
            .onClick(() => {
              if (this.isAgreementChecked) {
                // Target page (invoice main interface) is not in current page set.
                console.info('[InvoiceSetup] 确定按钮被点击，目标发票功能主界面不在当前页面集合中');
              }
            })
            .margin({ left: 16, right: 16, top: 24, bottom: 16 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ===== Bottom Tab Bar =====
      Row() {
        // Tab: 文件
        Column({ space: 2 }) {
          Text('📁')
            .fontSize(20)
          Text('文件')
            .fontSize(11)
            .fontColor('#999999')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 8, bottom: 6 })
        .onClick(() => {
          // Same-page tab switch — '文件' tab target not in current page set.
          console.info('[InvoiceSetup] 文件 Tab 被点击，同页切换，目标页不在当前页面集合中');
        })

        // Tab: 中转站
        Column({ space: 2 }) {
          Text('🔄')
            .fontSize(20)
          Text('中转站')
            .fontSize(11)
            .fontColor('#999999')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 8, bottom: 6 })
        .onClick(() => {
          // Same-page tab switch — '中转站' tab target not in current page set.
          console.info('[InvoiceSetup] 中转站 Tab 被点击，同页切换，目标页不在当前页面集合中');
        })

        // Tab: 发票 (selected)
        Column({ space: 2 }) {
          Text('🧾')
            .fontSize(20)
          Text('发票')
            .fontSize(11)
            .fontColor('#4CAF50')
            .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 8, bottom: 6 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .padding({ bottom: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
