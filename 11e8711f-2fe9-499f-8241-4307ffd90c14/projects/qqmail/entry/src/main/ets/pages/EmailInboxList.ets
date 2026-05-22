import { router } from '@kit.ArkUI';

// ── Data Models ──

interface MailItemData {
  id: string;
  senderIcon: string;
  senderIconBgColor: string;
  senderName: string;
  senderSubtitle?: string;
  badge?: string;
  subject: string;
  preview: string;
  timestamp: string;
  unread: boolean;
  isAd: boolean;
}

interface FolderItemData {
  label: string;
  badge?: string;
  selected: boolean;
}

// ── Mock Data ──

const MAIL_LIST_DATA: MailItemData[] = [
  {
    id: 'mail_0',
    senderIcon: '鲸',
    senderIconBgColor: '#4A90D9',
    senderName: '鲸匠装饰',
    badge: '广告',
    subject: '地点：南京 项目：旧房翻新 活动：一价全包 附：2026价目表[机智]',
    preview: '',
    timestamp: '',
    unread: false,
    isAd: true
  },
  {
    id: 'mail_1',
    senderIcon: 'AD',
    senderIconBgColor: '#FF8C00',
    senderName: '广告邮件',
    badge: '156',
    subject: 'OpenAI, 招商银行信用卡, Kaggle, 华盛证券, ...',
    preview: 'A new class of intelligence for real work',
    timestamp: '08:21',
    unread: true,
    isAd: true
  },
  {
    id: 'mail_2',
    senderIcon: '招',
    senderIconBgColor: '#D4213D',
    senderName: '招商银行信用卡',
    senderSubtitle: '每日信用管家',
    subject: '截至昨日最后一笔交易，您的额度和积分信息如下：',
    preview: '…30 … 可用…',
    timestamp: '12:11',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_3',
    senderIcon: 'O',
    senderIconBgColor: '#10A37F',
    senderName: 'OpenAI',
    subject: 'Introducing GPT-5.5',
    preview: 'A new class of intelligence for real work',
    timestamp: '08:21',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_4',
    senderIcon: 'Ov',
    senderIconBgColor: '#4CAF50',
    senderName: 'Overleaf',
    subject: '"Association for Computing Machinery (ACM)..."',
    preview: 'Overleaf Project Invite You have been invited to an Overleaf project.',
    timestamp: '前天 18:49',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_5',
    senderIcon: 'Op',
    senderIconBgColor: '#7C4DFF',
    senderName: 'OpenRouter, Inc',
    subject: 'Your OpenRouter, Inc refund [#3044-8440]',
    preview: 'Refund from OpenRouter, Inc [#3044-8440] Refunded $10.00',
    timestamp: '4月22日',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_6',
    senderIcon: 'Op',
    senderIconBgColor: '#7C4DFF',
    senderName: 'OpenRouter, Inc',
    subject: 'Your OpenRouter, Inc refund [#3480-9365]',
    preview: 'Refund from OpenRouter, Inc [#3480-9365] Refunded $30.00',
    timestamp: '4月22日',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_7',
    senderIcon: 'Op',
    senderIconBgColor: '#7C4DFF',
    senderName: 'OpenRouter, Inc',
    subject: 'Your OpenRouter, Inc receipt [#1265-4960]',
    preview: 'Receipt from OpenRouter, Inc [#1265-4960] Amount paid $31.65',
    timestamp: '4月22日',
    unread: true,
    isAd: false
  },
  {
    id: 'mail_8',
    senderIcon: 'Op',
    senderIconBgColor: '#7C4DFF',
    senderName: 'OpenRouter, Inc',
    subject: 'Your OpenRouter, Inc receipt [#1335-1509]',
    preview: 'Receipt from OpenRouter, Inc [#1335-1509] Amount paid $10.80',
    timestamp: '4月22日',
    unread: true,
    isAd: false
  }
];

const DRAWER_FOLDERS: FolderItemData[] = [
  { label: '收件箱', badge: '357', selected: true },
  { label: '星标邮件', selected: false },
  { label: '已发送', selected: false },
  { label: '草稿箱', selected: false },
  { label: '已删除', selected: false },
  { label: '垃圾箱', badge: '1', selected: false },
  { label: '未读邮件', badge: '821', selected: false },
  { label: '群邮件', selected: false },
  { label: '重要联系人', selected: false },
  { label: 'QQ邮件订阅', selected: false },
  { label: 'dear', selected: false },
  { label: '邮件归档', badge: '69', selected: false },
  { label: '管理', selected: false }
];

// ── Page Component ──

@Entry
@Component
export struct EmailInboxList {
  @State activeTabIndex: number = 0;
  @State isDrawerOpen: boolean = false;
  @State selectedFolderIndex: number = 0;

  private tabLabels: string[] = ['收件箱', '未读邮件', '管理'];

  // ── Computed mail list based on active tab ──
  private getFilteredMailList(): MailItemData[] {
    if (this.activeTabIndex === 1) {
      return MAIL_LIST_DATA.filter((item: MailItemData): boolean => item.unread);
    }
    return MAIL_LIST_DATA;
  }

  // ── Navigation handlers ──
  private onBackClick(): void {
    router.back();
  }

  private onMailItemClick(mailId: string): void {
    router.pushUrl({ url: 'pages/EmailDetail', params: { mailId: mailId } });
  }

  private onEditClick(): void {
    console.info('Edit button clicked — batch management mode toggle');
  }

  private onSearchFocus(): void {
    console.info('Search bar focused — search activation');
  }

  private onDrawerToggle(): void {
    this.isDrawerOpen = !this.isDrawerOpen;
  }

  private onDrawerClose(): void {
    this.isDrawerOpen = false;
  }

  private onFolderSelect(index: number): void {
    this.selectedFolderIndex = index;
    this.isDrawerOpen = false;
  }

  // ── Build ──

  build() {
    Stack() {
      Column() {
        this.NavigationBarSection();
        this.SearchBarSection();
        this.TabBarSection();
        this.MailListSection();
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      if (this.isDrawerOpen) {
        this.DrawerOverlay();
      }
    }
    .width('100%')
    .height('100%')
  }

  // ── Navigation Bar ──
  @Builder
  NavigationBarSection() {
    Row() {
      Text('<')
        .fontSize(22)
        .fontColor('#007AFF')
        .fontWeight(FontWeight.Medium)
        .padding({ left: 16, right: 8, top: 12, bottom: 12 })
        .onClick(() => this.onBackClick())

      Column() {
        Text('434@qq.com')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: 4, top: 12, bottom: 12 })

      Text('✎')
        .fontSize(20)
        .fontColor('#007AFF')
        .padding({ left: 8, right: 16, top: 12, bottom: 12 })
        .onClick(() => this.onEditClick())
    }
    .width('100%')
    .height(48)
    .backgroundColor('#FFFFFF')
    .border({ width: { bottom: 0.5 }, color: '#E0E0E0' })
  }

  // ── Search Bar ──
  @Builder
  SearchBarSection() {
    Row() {
      Text('🔍')
        .fontSize(16)
        .margin({ left: 12 })

      Text('搜索')
        .fontSize(15)
        .fontColor('#999999')
        .margin({ left: 6 })

      Blank()
    }
    .width('100%')
    .height(36)
    .backgroundColor('#EBEBEB')
    .borderRadius(8)
    .margin({ left: 12, right: 12, top: 8, bottom: 4 })
    .onClick(() => this.onSearchFocus())
  }

  // ── Tab Bar ──
  @Builder
  TabBarSection() {
    Row() {
      ForEach(this.tabLabels, (label: string, index: number) => {
        Column() {
          Text(label)
            .fontSize(15)
            .fontWeight(this.activeTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.activeTabIndex === index ? '#007AFF' : '#666666')
            .padding({ top: 10, bottom: 8 })

          if (this.activeTabIndex === index) {
            Divider()
              .width(28)
              .height(2)
              .color('#007AFF')
              .strokeWidth(2)
          } else {
            Divider()
              .width(28)
              .height(2)
              .color(Color.Transparent)
              .strokeWidth(2)
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.activeTabIndex = index;
        })
      })
    }
    .width('100%')
    .height(44)
    .backgroundColor('#FFFFFF')
    .border({ width: { bottom: 0.5 }, color: '#E0E0E0' })
  }

  // ── Mail List ──
  @Builder
  MailListSection() {
    Scroll() {
      Column() {
        Row() {
          Text('1个文件夹有新邮件')
            .fontSize(13)
            .fontColor('#007AFF')
        }
        .width('100%')
        .padding({ left: 16, top: 8, bottom: 8 })
        .backgroundColor('#E8F0FE')

        ForEach(this.getFilteredMailList(), (item: MailItemData, index: number) => {
          this.MailItemRow(item, index);
        })
      }
      .width('100%')
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  // ── Single Mail Item Row ──
  @Builder
  MailItemRow(item: MailItemData, index: number) {
    Row() {
      if (item.isAd) {
        Text('AD')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#FF8C00')
          .textAlign(TextAlign.Center)
      } else {
        Text(item.senderIcon)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor(item.senderIconBgColor)
          .textAlign(TextAlign.Center)
      }

      Column() {
        Row() {
          Text(item.senderName)
            .fontSize(16)
            .fontWeight(item.unread ? FontWeight.Bold : FontWeight.Normal)
            .fontColor('#000000')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          if (item.isAd && item.badge === '广告') {
            Text(item.badge)
              .fontSize(10)
              .fontColor('#FF8C00')
              .padding({ left: 4, right: 4, top: 1, bottom: 1 })
              .border({ width: 0.5, color: '#FF8C00', style: BorderStyle.Solid })
              .borderRadius(2)
              .margin({ left: 4 })
          }

          if (item.isAd && item.badge && item.badge !== '广告') {
            Text(item.badge)
              .fontSize(11)
              .fontColor('#FFFFFF')
              .padding({ left: 5, right: 5, top: 1, bottom: 1 })
              .backgroundColor('#FF8C00')
              .borderRadius(8)
              .margin({ left: 4 })
          }

          Blank()

          if (item.timestamp) {
            Text(item.timestamp)
              .fontSize(12)
              .fontColor('#AAAAAA')
          }

          if (item.unread && !item.isAd) {
            Circle({ width: 8, height: 8 })
              .fill('#007AFF')
              .margin({ left: 6 })
          }

          Text('›')
            .fontSize(18)
            .fontColor('#CCCCCC')
            .margin({ left: 4 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        if (item.senderSubtitle) {
          Text(item.senderSubtitle)
            .fontSize(12)
            .fontColor('#999999')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 1 })
        }

        Text(item.subject)
          .fontSize(14)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        if (item.preview) {
          Text(item.preview)
            .fontSize(12)
            .fontColor('#999999')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 1 })
        }
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 16, right: 12, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
    .onClick(() => this.onMailItemClick(item.id))
  }

  // ── Drawer Overlay ──
  @Builder
  DrawerOverlay() {
    Row() {
      Column() {
        Row() {
          Text('收件箱')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')

          Blank()

          if (DRAWER_FOLDERS[this.selectedFolderIndex].badge) {
            Text(DRAWER_FOLDERS[this.selectedFolderIndex].badge!)
              .fontSize(13)
              .fontColor('#FFFFFF')
              .padding({ left: 8, right: 8, top: 2, bottom: 2 })
              .backgroundColor('#4DA3FF')
              .borderRadius(10)
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 14, bottom: 14 })
        .backgroundColor('#007AFF')

        Scroll() {
          Column() {
            ForEach(DRAWER_FOLDERS, (folder: FolderItemData, idx: number) => {
              this.DrawerFolderItem(folder, idx);
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor('#FFFFFF')
      }
      .width('75%')
      .height('100%')

      Column()
        .width('25%')
        .height('100%')
        .backgroundColor('#33000000')
        .onClick(() => this.onDrawerClose())
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DrawerFolderItem(folder: FolderItemData, idx: number) {
    Row() {
      Text(folder.label)
        .fontSize(16)
        .fontColor(folder.selected ? '#007AFF' : '#333333')
        .fontWeight(folder.selected ? FontWeight.Medium : FontWeight.Normal)
        .layoutWeight(1)

      if (folder.badge) {
        Text(folder.badge)
          .fontSize(12)
          .fontColor('#666666')
          .padding({ left: 8, right: 8, top: 2, bottom: 2 })
          .backgroundColor('#E8F0FE')
          .borderRadius(10)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
    .backgroundColor(folder.selected ? '#E8F0FE' : '#FFFFFF')
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
    .onClick(() => this.onFolderSelect(idx))
  }
}
