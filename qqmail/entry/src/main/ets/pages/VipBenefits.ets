import router from '@ohos.router';

// ── Data Models ──

interface BenefitCardData {
  id: string;
  iconSymbol: string;
  title: string;
  description: string;
  progressCurrent?: string;
  progressMax?: string;
  showProgress: boolean;
  actionLabel: string;
}

interface FeatureItemData {
  id: string;
  iconSymbol: string;
  title: string;
  subtitle: string;
}

// ── Entry Component ──

@Entry
@Component
export struct VipBenefits {
  // ── Benefit Cards Data ──

  private benefitCards: BenefitCardData[] = [
    {
      id: 'mail_capacity',
      iconSymbol: '✉️',
      title: '2T 邮箱容量',
      description: '2GB 升级至 2TB',
      progressCurrent: '1.2GB',
      progressMax: '4GB',
      showProgress: true,
      actionLabel: '去了解'
    },
    {
      id: 'cloud_capacity',
      iconSymbol: '☁️',
      title: '2T 云盘容量',
      description: '3GB 升级至 2TB',
      progressCurrent: '423KB',
      progressMax: '3GB',
      showProgress: true,
      actionLabel: '去了解'
    },
    {
      id: 'large_attachment',
      iconSymbol: '📎',
      title: '10G 超大附件',
      description: '邮件附件支持 10GB',
      showProgress: false,
      actionLabel: '去了解'
    },
    {
      id: 'vip_identity',
      iconSymbol: '👑',
      title: '尊享会员身份',
      description: '专属 VIP 地址和徽标',
      showProgress: false,
      actionLabel: '去了解'
    }
  ];

  // ── Extended Features Data ──

  private extendedFeatures: FeatureItemData[] = [
    { id: 'large_attach', iconSymbol: '📅', title: '超大附件', subtitle: '有效期90天' },
    { id: 'unzip', iconSymbol: '🗜️', title: '在线解压', subtitle: '最大10GB' },
    { id: 'image_export', iconSymbol: '📊', title: '图片导出表格', subtitle: '以Excel文件导出' },
    { id: 'personal_email', iconSymbol: '@️', title: '个性化邮箱地址', subtitle: '设置域名为地址' },
    { id: 'no_ads', iconSymbol: '🚫', title: '会员免广告', subtitle: '邮箱免广告' },
    { id: 'fast_transfer', iconSymbol: '⬆️', title: '高速上传下载', subtitle: '大文件传输无阻' },
    { id: 'attachment_scan', iconSymbol: '🔍', title: '附件深度查杀', subtitle: '防范病毒邮件附件' },
    { id: 'malware_detect', iconSymbol: '🛡️', title: '恶意邮件识别', subtitle: '防范邮件钓鱼风险' },
    { id: 'ai_fraud', iconSymbol: '🤖', title: 'AI防欺诈', subtitle: '90天自助查询' }
  ];

  // ── Navigation ──

  private handleBack(): void {
    try {
      router.back();
    } catch (error) {
      console.error('Navigation back failed:', JSON.stringify(error));
    }
  }

  private handleMoreMenu(): void {
    // More menu overlay — not a page navigation
    console.info('More menu tapped');
  }

  private handleOpenVip(): void {
    // Target page (payment/activation flow) not in current page set
    console.info('Open VIP activation flow — target page not in current page set');
  }

  private handleLearnMore(benefitId: string): void {
    // Target detail pages not in current page set
    console.info(`Learn more about ${benefitId} — target page not in current page set`);
  }

  // ── Builders ──

  @Builder
  buildNavBar() {
    Row() {
      // Back button
      Text('←')
        .fontSize(22)
        .fontColor('#333333')
        .padding({ left: 4, right: 12, top: 4, bottom: 4 })
        .onClick(() => this.handleBack())

      Blank()

      // Title
      Text('QQ邮箱会员')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1A1A')

      Blank()

      // More menu button
      Text('⋯')
        .fontSize(22)
        .fontColor('#333333')
        .padding({ left: 12, right: 4, top: 4, bottom: 4 })
        .onClick(() => this.handleMoreMenu())
    }
    .width('100%')
    .height(48)
    .padding({ left: 12, right: 12 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildUserProfile() {
    Row({ space: 10 }) {
      // Avatar placeholder
      Text('👤')
        .fontSize(28)
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor('#E8E8E8')
        .textAlign(TextAlign.Center)

      // Username
      Text('蒋')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1A1A')

      // Status badge
      Text('未开通')
        .fontSize(12)
        .fontColor('#999999')
        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
        .borderRadius(10)
        .backgroundColor('#F0F0F0')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildVipBanner() {
    Column({ space: 8 }) {
      // VIP icon + headline row
      Row({ space: 6 }) {
        Text('✓')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#7C5CFC')
          .textAlign(TextAlign.Center)

        Text('邮箱VIP')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }

      // Subhead
      Text('开通会员，让邮箱更好用')
        .fontSize(14)
        .fontColor('rgba(255, 255, 255, 0.85)')

      // CTA Button
      Column({ space: 2 }) {
        Text('开通')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#7C5CFC')
          .padding({ left: 32, right: 32, top: 10, bottom: 10 })
          .borderRadius(20)
          .backgroundColor('#FFFFFF')
          .onClick(() => this.handleOpenVip())

        Text('每月只需17.5元')
          .fontSize(11)
          .fontColor('rgba(255, 255, 255, 0.7)')
      }
      .margin({ top: 4 })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20, bottom: 20 })
    .borderRadius(12)
    .backgroundColor('#7C5CFC')
    .margin({ left: 16, right: 16, top: 8, bottom: 4 })
  }

  @Builder
  buildSectionHeader(title: string) {
    Text(title)
      .fontSize(15)
      .fontWeight(FontWeight.Medium)
      .fontColor('#333333')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })
      .width('100%')
  }

  @Builder
  buildBenefitCard(card: BenefitCardData) {
    Column({ space: 6 }) {
      // Icon
      Text(card.iconSymbol)
        .fontSize(24)
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor('#F5F0FF')
        .textAlign(TextAlign.Center)

      // Title
      Text(card.title)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1A1A')

      // Description
      Text(card.description)
        .fontSize(12)
        .fontColor('#999999')

      // Progress bar (if applicable)
      if (card.showProgress && card.progressCurrent && card.progressMax) {
        Column({ space: 4 }) {
          Row() {
            Text(card.progressCurrent)
              .fontSize(11)
              .fontColor('#666666')
            Blank()
            Text(card.progressMax)
              .fontSize(11)
              .fontColor('#999999')
          }
          .width('100%')

          // Progress bar track
          Stack() {
            // Background track
            Row()
              .width('100%')
              .height(4)
              .borderRadius(2)
              .backgroundColor('#E8E8E8')

            // Filled portion (approximate based on data)
            Row()
              .width('30%')
              .height(4)
              .borderRadius(2)
              .backgroundColor('#7C5CFC')
          }
          .width('100%')
        }
        .width('100%')
      }

      // Action link
      Text(card.actionLabel)
        .fontSize(13)
        .fontColor('#7C5CFC')
        .padding({ top: 4 })
        .onClick(() => this.handleLearnMore(card.id))
    }
    .width('100%')
    .padding({ left: 14, right: 14, top: 14, bottom: 14 })
    .borderRadius(10)
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.06)',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  buildBenefitsGrid() {
    Column() {
      // Row 1
      Row({ space: 10 }) {
        Column() {
          this.buildBenefitCard(this.benefitCards[0])
        }
        .layoutWeight(1)

        Column() {
          this.buildBenefitCard(this.benefitCards[1])
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // Row 2
      Row({ space: 10 }) {
        Column() {
          this.buildBenefitCard(this.benefitCards[2])
        }
        .layoutWeight(1)

        Column() {
          this.buildBenefitCard(this.benefitCards[3])
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 10 })
    }
  }

  @Builder
  buildFeatureItem(feature: FeatureItemData) {
    Row({ space: 12 }) {
      // Icon
      Text(feature.iconSymbol)
        .fontSize(20)
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor('#F5F5F5')
        .textAlign(TextAlign.Center)

      // Title + Subtitle
      Column({ space: 2 }) {
        Text(feature.title)
          .fontSize(15)
          .fontColor('#1A1A1A')

        Text(feature.subtitle)
          .fontSize(12)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Right arrow
      Text('›')
        .fontSize(18)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildExtendedFeaturesList() {
    Column() {
      ForEach(this.extendedFeatures, (feature: FeatureItemData, index: number) => {
        Column() {
          this.buildFeatureItem(feature)
          if (index < this.extendedFeatures.length - 1) {
            Divider()
              .strokeWidth(0.5)
              .color('#F0F0F0')
              .margin({ left: 64 })
          }
        }
      })
    }
    .width('100%')
    .borderRadius(10)
    .margin({ left: 16, right: 16 })
    .clip(true)
  }

  // ── Main Build ──

  build() {
    Column() {
      // Sticky navigation bar
      this.buildNavBar()

      // Scrollable content
      Scroll() {
        Column() {
          // User profile section
          this.buildUserProfile()

          // VIP promo banner
          this.buildVipBanner()

          // Section header
          this.buildSectionHeader('会员享以下权益')

          // 2×2 Benefits grid
          this.buildBenefitsGrid()

          // Section header for extended features
          this.buildSectionHeader('更多会员权益')

          // Extended features list
          this.buildExtendedFeaturesList()

          // Bottom spacer
          Column()
            .height(24)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
