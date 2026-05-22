import router from '@ohos.router';

// ── Data Models ──

interface SidebarItem {
  id: string;
  icon: string;
  text: string;
  badge?: string;
  badgeType?: 'count' | 'dot';
  route?: string;
}

interface SidebarSection {
  label: string;
  items: SidebarItem[];
}

interface ActionSheetItem {
  id: string;
  icon: string;
  text: string;
  route?: string;
}

// ── Entry Component ──

@Entry
@Component
export struct SidebarNavigation {
  @State showActionSheet: boolean = false;

  // ── Section Data ──

  private myMailItems: SidebarItem[] = [
    { id: 'inbox', icon: '📥', text: '收件箱', badge: '360', badgeType: 'count', route: 'pages/EmailInboxList' },
    { id: 'important_contacts', icon: '⭐', text: '重要联系人', route: 'pages/ImportantContacts' },
    { id: 'starred', icon: '★', text: '星标邮件' }
  ];

  private myAppsItems: SidebarItem[] = [
    { id: 'cloud', icon: '☁️', text: '文件云盘', badge: '●', badgeType: 'dot' },
    { id: 'invoice', icon: '📄', text: '发票', badge: '●', badgeType: 'dot', route: 'pages/InvoiceSetup' },
    { id: 'contacts', icon: '👤', text: '通讯录' },
    { id: 'attachments', icon: '📎', text: '附件管理' },
    { id: 'daily_read', icon: '📖', text: '每日悦读', badge: '●', badgeType: 'dot' },
    { id: 'notebook', icon: '📝', text: '记事本' },
    { id: 'calendar', icon: '📅', text: '日历', badge: '25', badgeType: 'count' },
    { id: 'more_apps', icon: '⊞', text: '更多应用' }
  ];

  private folderItems: SidebarItem[] = [
    { id: 'sent', icon: '📤', text: '已发送' },
    { id: 'drafts', icon: '📝', text: '草稿箱' },
    { id: 'deleted', icon: '🗑️', text: '已删除' },
    { id: 'trash', icon: '🗑️', text: '垃圾箱', badge: '1', badgeType: 'count' },
    { id: 'group_mail', icon: '📁', text: '群邮件' },
    { id: 'qq_sub', icon: '📁', text: 'QQ邮件订阅' },
    { id: 'dear', icon: '📁', text: 'dear' },
    { id: 'archive', icon: '📁', text: '邮件归档', badge: '69', badgeType: 'count' },
    { id: 'cmb', icon: '📁', text: '招商银行信用卡', badge: '395', badgeType: 'count' }
  ];

  private actionSheetItems: ActionSheetItem[] = [
    { id: 'compose', icon: '✏️', text: '写邮件', route: 'pages/ComposeEmail' },
    { id: 'note', icon: '📝', text: '写记事' },
    { id: 'scan', icon: '📷', text: '扫一扫' },
    { id: 'settings', icon: '⚙️', text: '设置', route: 'pages/SettingsRoot' }
  ];

  // ── Navigation ──

  private handleItemTap(item: SidebarItem): void {
    if (item.route) {
      try {
        router.pushUrl({ url: item.route });
      } catch (error) {
        console.error(`Navigation to ${item.route} failed:`, JSON.stringify(error));
      }
    } else {
      // Placeholder for items without confirmed routes
      console.info(`Item tapped: ${item.text} — target page not in current page set`);
    }
  }

  private handleMemberCenterTap(): void {
    try {
      router.pushUrl({ url: 'pages/VipBenefits' });
    } catch (error) {
      console.error('Navigation to VipBenefits failed:', JSON.stringify(error));
    }
  }

  private handleActionSheetItemTap(item: ActionSheetItem): void {
    this.showActionSheet = false;
    if (item.route) {
      try {
        router.pushUrl({ url: item.route });
      } catch (error) {
        console.error(`Navigation to ${item.route} failed:`, JSON.stringify(error));
      }
    } else {
      console.info(`Action sheet item tapped: ${item.text} — target page not in current page set`);
    }
  }

  private toggleActionSheet(): void {
    this.showActionSheet = !this.showActionSheet;
  }

  // ── Builders ──

  @Builder
  buildHeaderBar(): void {
    Row() {
      // Avatar + User Info
      Row({ space: 12 }) {
        // Avatar
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#7B68EE')
          Text('莜')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }

        // Username + V badge + Member center
        Column({ space: 2 }) {
          Row({ space: 4 }) {
            Text('莜')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
            // V badge
            Text('V')
              .fontSize(10)
              .fontColor('#FFFFFF')
              .backgroundColor('#4A90D9')
              .borderRadius(2)
              .padding({ left: 3, right: 3, top: 1, bottom: 1 })
          }
          Row() {
            Text('会员中心')
              .fontSize(13)
              .fontColor('#888888')
            Text(' >')
              .fontSize(13)
              .fontColor('#888888')
          }
          .onClick(() => {
            this.handleMemberCenterTap();
          })
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      // + Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#333333')
          .fontWeight(FontWeight.Lighter)
      }
      .width(36)
      .height(36)
      .backgroundColor('#F0F0F0')
      .borderRadius(18)
      .onClick(() => {
        this.toggleActionSheet();
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildSectionLabel(label: string): void {
    Text(label)
      .fontSize(13)
      .fontColor('#999999')
      .padding({ left: 16, top: 16, bottom: 6 })
      .width('100%')
  }

  @Builder
  buildListItem(item: SidebarItem): void {
    Row({ space: 12 }) {
      // Icon
      Text(item.icon)
        .fontSize(20)

      // Text
      Text(item.text)
        .fontSize(16)
        .fontColor('#1A1A1A')
        .layoutWeight(1)

      // Badge
      if (item.badge) {
        if (item.badgeType === 'dot') {
          Circle()
            .width(8)
            .height(8)
            .fill('#FF4444')
        } else {
          Text(item.badge)
            .fontSize(13)
            .fontColor('#FFFFFF')
            .backgroundColor('#4A90D9')
            .borderRadius(10)
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .constraintSize({ minWidth: 20 })
            .textAlign(TextAlign.Center)
        }
      }

      // Chevron
      Text('›')
        .fontSize(18)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .height(48)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      this.handleItemTap(item);
    })
  }

  @Builder
  buildSection(section: SidebarSection): void {
    Column() {
      this.buildSectionLabel(section.label)
      ForEach(section.items, (item: SidebarItem, index: number) => {
        this.buildListItem(item)
        if (index < section.items.length - 1) {
          Divider()
            .strokeWidth(0.5)
            .color('#F0F0F0')
            .margin({ left: 52 })
        }
      })
    }
    .width('100%')
    .margin({ bottom: 8 })
  }

  @Builder
  buildActionSheet(): void {
    Column() {
      // Backdrop
      Column()
        .width('100%')
        .layoutWeight(1)
        .onClick(() => {
          this.showActionSheet = false;
        })

      // Action sheet panel
      Column() {
        // Arrow indicator
        Row() {
          Blank()
          // Triangle pointer
          Text('▲')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .margin({ right: 24 })
        }
        .width('100%')

        // Action items
        Column() {
          ForEach(this.actionSheetItems, (item: ActionSheetItem, index: number) => {
            Row({ space: 14 }) {
              Text(item.icon)
                .fontSize(20)
              Text(item.text)
                .fontSize(16)
                .fontColor('#1A1A1A')
            }
            .width('100%')
            .height(48)
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              this.handleActionSheetItemTap(item);
            })

            if (index < this.actionSheetItems.length - 1) {
              Divider()
                .strokeWidth(0.5)
                .color('#F0F0F0')
                .margin({ left: 54, right: 20 })
            }
          })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .backgroundColor('rgba(0, 0, 0, 0.4)')
  }

  // ── Main Build ──

  build() {
    Stack() {
      // Main content
      Column() {
        // Header bar (fixed)
        this.buildHeaderBar()

        // Scrollable content
        Scroll() {
          Column() {
            // Section: 我的邮件
            this.buildSection({
              label: '我的邮件',
              items: this.myMailItems
            })

            // Section: 我的应用
            this.buildSection({
              label: '我的应用',
              items: this.myAppsItems
            })

            // Section: 文件夹
            this.buildSection({
              label: '文件夹',
              items: this.folderItems
            })

            // Bottom spacer
            Column()
              .height(20)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // Action sheet overlay
      if (this.showActionSheet) {
        this.buildActionSheet()
      }
    }
    .width('100%')
    .height('100%')
  }
}
