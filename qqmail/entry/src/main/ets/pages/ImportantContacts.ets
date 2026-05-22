import { router } from '@kit.ArkUI';

@Entry
@Component
export struct ImportantContacts {
  build() {
    Column() {
      // Navigation bar
      Row() {
        // Back button
        Text('<')
          .fontSize(20)
          .fontColor('#333333')
          .padding({ left: 16, right: 8, top: 12, bottom: 12 })
          .onClick(() => {
            router.back();
          })

        Blank()

        // Title
        Text('重要联系人')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Blank()

        // Right slot placeholder (same width as back button for symmetry)
        Row()
          .width(44)
          .height(44)
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // Empty state area
      Column() {
        // Envelope + bookmark icon (using text symbol as placeholder)
        Text('✉')
          .fontSize(64)
          .fontColor('#CCCCCC')
          .margin({ bottom: 16 })

        // Description text
        Text('快速查看重要联系人的来信')
          .fontSize(15)
          .fontColor('#999999')
          .margin({ bottom: 24 })

        // Add important contact CTA (blue link style)
        Text('添加重要联系人')
          .fontSize(15)
          .fontColor('#007AFF')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            // Target page (add important contact form/selector) is not in the current page set.
            // Placeholder: log the action.
            console.info('[ImportantContacts] 添加重要联系人 - target page not in current page set');
          })
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
