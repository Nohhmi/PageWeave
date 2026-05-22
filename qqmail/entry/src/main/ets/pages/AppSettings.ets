import { router } from '@kit.ArkUI';

interface AppSettingItem {
  id: string;
  label: string;
  status: string;
}

@Entry
@Component
export struct AppSettings {
  private settingItems: AppSettingItem[] = [
    { id: 'item_contacts', label: '通讯录', status: '开启' },
    { id: 'item_cloud', label: '文件云盘', status: '开启' },
    { id: 'item_attachments', label: '附件管理', status: '开启' },
    { id: 'item_daily_read', label: '每日悦读', status: '开启' },
    { id: 'item_invoice', label: '发票', status: '开启' },
    { id: 'item_notebook', label: '记事本', status: '开启' },
    { id: 'item_calendar', label: '日历', status: '开启' },
    { id: 'item_online_docs', label: '在线文档', status: '开启' },
    { id: 'item_greeting_card', label: '贺卡', status: '开启' },
  ];

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

        Text('应用设置')
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

      // Scrollable feature list
      Scroll() {
        Column() {
          ForEach(this.settingItems, (item: AppSettingItem, index: number) => {
            Column() {
              Row() {
                Text(item.label)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Text(item.status)
                  .fontSize(14)
                  .fontColor('#999999')
                  .margin({ right: 8 })

                Text('>')
                  .fontSize(16)
                  .fontColor('#C0C0C0')
              }
              .width('100%')
              .height(56)
              .padding({ left: 16, right: 16 })
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                console.info(`${item.label} - 目标子设置页不在当前页面集合中`);
              })

              // Divider between items (not after last)
              if (index < this.settingItems.length - 1) {
                Divider()
                  .strokeWidth(0.5)
                  .color('#E8E8E8')
                  .margin({ left: 16 })
              }
            }
            .width('100%')
          })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
