export class NavigationService {
  static primaryPageNames(): string[] {
    return [
      '邮件收件箱列表页',
      '邮箱侧边栏导航页',
      'QQ邮箱会员权益页',
      '写邮件页',
      '邮件详情页',
      '重要联系人页',
      '发票功能开通页',
      '应用设置页',
      '设置页',
      '新邮件提醒引导页',
      '通用设置页'
    ];
  }

  static routeFor(pageName: string): string {
    switch (pageName) {
      case '邮件收件箱列表页':
        return 'pages/EmailInboxList';
      case '邮箱侧边栏导航页':
        return 'pages/SidebarNavigation';
      case 'QQ邮箱会员权益页':
        return 'pages/VipBenefits';
      case '写邮件页':
        return 'pages/ComposeEmail';
      case '邮件详情页':
        return 'pages/EmailDetail';
      case '重要联系人页':
        return 'pages/ImportantContacts';
      case '发票功能开通页':
        return 'pages/InvoiceSetup';
      case '应用设置页':
        return 'pages/AppSettings';
      case '设置页':
        return 'pages/SettingsRoot';
      case '新邮件提醒引导页':
        return 'pages/NotificationGuide';
      case '通用设置页':
        return 'pages/GeneralSettings';
      default:
        return 'pages/Index';
    }
  }
}
