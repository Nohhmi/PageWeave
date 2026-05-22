# 功能总结

## 页面功能
### ability=EntryAbility|page=pages/ComposeEmail
- 未观察到可确认的非跳转交互功能

### ability=EntryAbility|page=pages/EmailDetail
- 支持点击“隐藏”触发界面状态变化（置信度: low）

### ability=EntryAbility|page=pages/EmailInboxList
- 支持点击Column组件触发界面状态变化（置信度: low）

### ability=EntryAbility|page=pages/ImportantContacts
- 未观察到可确认的非跳转交互功能

### ability=EntryAbility|page=pages/InvoiceSetup
- 支持点击“agreement”触发界面状态变化（置信度: low）

### ability=EntryAbility|page=pages/SidebarNavigation
- 支持点击Button组件触发界面状态变化（置信度: low）
- 支持交互操作后更新当前页面状态（置信度: low）

### ability=EntryAbility|page=pages/VipBenefits
- 支持交互操作后更新当前页面状态（置信度: low）
- 支持点击__Common__组件触发界面状态变化（置信度: low）

## 跳转功能
- ability=EntryAbility|page=pages/SidebarNavigation → ability=EntryAbility|page=pages/VipBenefits  [触发元素: Row:[266,276][488,329]]
- ability=EntryAbility|page=pages/VipBenefits → ability=EntryAbility|page=pages/SidebarNavigation  [触发元素: text:← (文本: ←)]
- ability=EntryAbility|page=pages/SidebarNavigation → ability=EntryAbility|page=pages/EmailInboxList  [触发元素: Row:[0,518][1320,686]]
- ability=EntryAbility|page=pages/EmailInboxList → ability=EntryAbility|page=pages/EmailDetail  [触发元素: Row:[0,735][1320,960]]
- ability=EntryAbility|page=pages/EmailDetail → ability=EntryAbility|page=pages/ComposeEmail  [触发元素: Column:[660,2583][990,2724]]
- ability=EntryAbility|page=pages/ComposeEmail → ability=EntryAbility|page=pages/EmailDetail  [触发元素: text:取消 (文本: 取消)]
- ability=EntryAbility|page=pages/SidebarNavigation → ability=EntryAbility|page=pages/ImportantContacts  [触发元素: Row:[0,688][1320,856]]
- ability=EntryAbility|page=pages/ImportantContacts → ability=EntryAbility|page=pages/SidebarNavigation  [触发元素: text:< (文本: <)]
- ability=EntryAbility|page=pages/SidebarNavigation → ability=EntryAbility|page=pages/InvoiceSetup  [触发元素: Row:[0,1354][1320,1522]]
- ability=EntryAbility|page=pages/InvoiceSetup → ability=EntryAbility|page=pages/SidebarNavigation  [触发元素: text:← (文本: ←)]
