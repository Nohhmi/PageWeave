import { router } from '@kit.ArkUI';

@Entry
@Component
export struct EmailDetail {
  @State showProxyDetail: boolean = true;
  @State showTranslateButton: boolean = true;

  build() {
    Column() {
      // Navigation bar: back button + up/down arrows
      Row() {
        // Back button
        Button() {
          Text('←')
            .fontSize(20)
            .fontColor('#333333')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
        .onClick(() => {
          router.back();
        })

        Blank()

        // Up/Down navigation arrows
        Row({ space: 16 }) {
          Button() {
            Text('▲')
              .fontSize(14)
              .fontColor('#666666')
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .width(32)
          .height(32)
          .onClick(() => {
            // Navigate to previous email in stack
          })

          Button() {
            Text('▼')
              .fontSize(14)
              .fontColor('#666666')
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .width(32)
          .height(32)
          .onClick(() => {
            // Navigate to next email in stack
          })
        }
      }
      .width('100%')
      .height(48)
      .padding({ left: 8, right: 12 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F8F8F8')
      .border({ width: { bottom: 0.5 }, color: '#E0E0E0' })

      // Scrollable content area
      Scroll() {
        Column() {
          // ===== Email Header =====
          Column({ space: 0 }) {
            // Subject line
            Text('Introducing GPT-5.5')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
              .width('100%')
              .padding({ left: 16, right: 16, top: 16, bottom: 12 })
              .lineHeight(28)

            // Divider
            Divider()
              .height(0.5)
              .color('#EEEEEE')
              .margin({ left: 16, right: 16 })

            // From field
            Column() {
              Row() {
                Text('发件人：')
                  .fontSize(14)
                  .fontColor('#999999')
                  .constraintSize({ maxWidth: 60 })

                Column({ space: 2 }) {
                  Row({ space: 4 }) {
                    Text('OpenAI')
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#333333')
                  }

                  Text('noreply@email.openai.com')
                    .fontSize(13)
                    .fontColor('#888888')
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Button('隐藏')
                  .fontSize(13)
                  .fontColor('#4A90D9')
                  .type(ButtonType.Normal)
                  .backgroundColor(Color.Transparent)
                  .height(28)
                  .padding({ left: 8, right: 8 })
                  .onClick(() => {
                    this.showProxyDetail = !this.showProxyDetail;
                  })
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              // Proxy note (toggleable)
              if (this.showProxyDetail) {
                Text('(由 bounces+54382...ail.openai.com 代发)')
                  .fontSize(12)
                  .fontColor('#AAAAAA')
                  .padding({ left: 60, top: 4 })
                  .width('100%')
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 10 })

            // Divider
            Divider()
              .height(0.5)
              .color('#EEEEEE')
              .margin({ left: 16, right: 16 })

            // To field
            Row() {
              Text('收件人：')
                .fontSize(14)
                .fontColor('#999999')
                .constraintSize({ maxWidth: 60 })

              Text('蒋')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text('****434@qq.com')
                .fontSize(13)
                .fontColor('#888888')
                .margin({ left: 4 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .alignItems(VerticalAlign.Center)

            // Divider
            Divider()
              .height(0.5)
              .color('#EEEEEE')
              .margin({ left: 16, right: 16 })

            // Timestamp field
            Row() {
              Text('时间：')
                .fontSize(14)
                .fontColor('#999999')
                .constraintSize({ maxWidth: 60 })

              Text('2026年4月25日 08:21')
                .fontSize(14)
                .fontColor('#666666')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 10, bottom: 12 })
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // Separator between header and body
          Row()
            .width('100%')
            .height(8)
            .backgroundColor('#F0F0F0')

          // ===== Email Body =====
          Column({ space: 0 }) {
            // Brand Logo
            Column() {
              Text('OpenAI')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor('#10A37F')
            }
            .width('100%')
            .padding({ top: 32, bottom: 24 })
            .alignItems(HorizontalAlign.Center)

            // Paragraph 1
            Text("We're excited to introduce GPT-5.5, our smartest and most intuitive to use model yet, and the next step toward a new way of getting work done on a computer. GPT-5.5 is now available in the API, Codex, and ChatGPT.")
              .fontSize(15)
              .fontColor('#333333')
              .lineHeight(24)
              .width('100%')
              .padding({ left: 16, right: 16, bottom: 16 })

            // Paragraph 2
            Text('GPT-5.5 understands what you\'re trying to do faster and can carry more of the work itself. It also uses significantly fewer tokens to complete the same tasks, making it more efficient as well as more capable.')
              .fontSize(15)
              .fontColor('#333333')
              .lineHeight(24)
              .width('100%')
              .padding({ left: 16, right: 16, bottom: 16 })

            // Paragraph 3 (with links and command snippet)
            Column({ space: 0 }) {
              Text() {
                Span('To get the most out of GPT-5.5 in the API, check out our API ')
                  .fontSize(15)
                  .fontColor('#333333')
                Span('prompt guide')
                  .fontSize(15)
                  .fontColor('#4A90D9')
                  .fontWeight(FontWeight.Medium)
                  .decoration({ type: TextDecorationType.Underline })
                Span(' and ')
                  .fontSize(15)
                  .fontColor('#333333')
                Span('migration guide')
                  .fontSize(15)
                  .fontColor('#4A90D9')
                  .fontWeight(FontWeight.Medium)
                  .decoration({ type: TextDecorationType.Underline })
                Span(', or use the command: ')
                  .fontSize(15)
                  .fontColor('#333333')
              }
              .lineHeight(24)
              .width('100%')
              .padding({ left: 16, right: 16, bottom: 12 })

              // Command snippet
              Text('[$openai-docs migrate this project to gpt-5.5]')
                .fontSize(13)
                .fontColor('#555555')
                .fontFamily('monospace')
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .margin({ left: 16, right: 16, bottom: 12 })

              Text() {
                Span(' to kick off a plan to migrate your API integration via Codex.')
                  .fontSize(15)
                  .fontColor('#333333')
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 16 })

            // Paragraph 4
            Text() {
              Span('GPT-5.5')
                .fontSize(15)
                .fontColor('#333333')
                .fontWeight(FontWeight.Bold)
              Span(' is now the default model in ')
                .fontSize(15)
                .fontColor('#333333')
              Span('Codex')
                .fontSize(15)
                .fontColor('#333333')
                .fontWeight(FontWeight.Bold)
            }
            .lineHeight(24)
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 32 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // Bottom spacer for floating button and action bar
          Column()
            .width('100%')
            .height(80)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ===== Bottom Action Bar =====
      Row() {
        // Delete
        Column({ space: 4 }) {
          Text('🗑')
            .fontSize(20)
          Text('删除')
            .fontSize(11)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          // Delete current email
        })

        // Share
        Column({ space: 4 }) {
          Text('↗')
            .fontSize(20)
          Text('分享')
            .fontSize(11)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          // Open system share panel
        })

        // Reply/Forward
        Column({ space: 4 }) {
          Text('↩')
            .fontSize(20)
          Text('回复转发')
            .fontSize(11)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.pushUrl({ url: 'pages/ComposeEmail' });
        })

        // More
        Column({ space: 4 }) {
          Text('⋯')
            .fontSize(20)
          Text('更多')
            .fontSize(11)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          // Open more actions menu
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FAFAFA')
      .border({ width: { top: 0.5 }, color: '#E0E0E0' })
      .padding({ bottom: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
