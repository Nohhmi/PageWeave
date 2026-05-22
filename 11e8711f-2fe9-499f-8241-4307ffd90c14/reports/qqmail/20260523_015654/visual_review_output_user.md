# Visual Review Summary

- runtime_image_count: 25
- reference_image_count: 15
- matched_count: 11
- reference_unmatched_count: 4
- avg_top1_score: 0.860161
- matching_mode: page_constrained

## Top1 Matches
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/9.png -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_ImportantContacts/init_screen.jpeg (score=0.966298)
  overall=PASS; similarity_score=90.0; 页面主结构、关键组件和文案均一致，仅图标风格略有差异，整体相似度高。
  suggestions=保持核心图标语义一致即可，无需完全匹配颜色或细节；建议统一图标风格以提升视觉一致性。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/2.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_SidebarNavigation/init_screen.jpeg (score=0.921988)
  overall=PASS; similarity_score=85.0; 页面主结构和关键组件一致，仅图标样式存在差异，底部文件夹内容略有不同，整体相似度较高。
  suggestions=保持核心功能布局一致，可统一图标风格以提升视觉一致性；注意底部文件夹区域内容需对齐设计规范。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/5.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_SidebarNavigation/elem3/after.jpeg (score=0.906197)
  overall=PASS; similarity_score=85.0; 两图整体结构一致，主要功能入口相同，仅在弹窗位置、图标细节及部分列表项上存在轻微差异，不影响用户体验。
  suggestions=保持弹窗位置一致，统一图标风格，确保核心功能入口一致。可忽略非关键的列表项差异。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/13.png -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_InvoiceSetup/init_screen.jpeg (score=0.893984)
  overall=PASS; similarity_score=85.0; 页面主结构一致，关键组件存在，主要文案语义相同，仅在按钮状态、图标样式和部分颜色细节上存在轻微差异，整体视觉体验大致相似。
  suggestions=建议统一底部按钮状态逻辑（如勾选后启用），并保持图标与品牌色一致；可忽略小图标风格差异，但需确保核心交互组件行为一致。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/3.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_SidebarNavigation/elem5/after.jpeg (score=0.888125)
  overall=FAIL; similarity_score=20.0; 两个页面内容和结构完全不同，一个是重要联系人空状态页，另一个是邮件应用的侧边栏菜单，无法视为相似。
  suggestions=请确认是否为同一页面的对比。若目标是验证‘重要联系人’页面，则应提供对应参考图；若需比对侧边栏导航，则当前图不匹配。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/4.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_VipBenefits/init_screen.jpeg (score=0.855508)
  overall=FAIL; similarity_score=65.0; 页面主结构基本一致，但关键组件缺失和布局差异导致整体相似度不足。特别是‘更多会员权益’部分内容严重不一致，影响用户体验一致性。
  suggestions=建议统一会员权益展示内容与布局，确保‘更多会员权益’部分完整呈现所有功能；调整开通按钮位置至右侧以匹配参考设计；优化进度条信息展示，增加当前容量说明。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/6.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_ComposeEmail/init_screen.jpeg (score=0.819014)
  overall=PASS; similarity_score=85.0; 两图整体结构一致，主要组件和文案语义相同，仅在键盘样式、底部图标和部分细节上存在轻微差异，不影响核心功能识别。
  suggestions=建议统一键盘样式以提升一致性；移除调试信息避免干扰视觉判断；保持底部功能图标的一致性。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/12.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_EmailDetail/elem1/after.jpeg (score=0.817792)
  overall=PASS; similarity_score=82.0; 两图整体结构和核心内容一致，主要差异在于部分文本内容缺失及底部组件存在细微差别，不影响主功能识别。
  suggestions=建议保持邮件正文内容完整性，尤其是API迁移相关指令；统一底部操作栏图标风格；若需支持翻译功能，应确保悬浮按钮在所有场景中一致呈现。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/1.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_EmailInboxList/elem1/after.jpeg (score=0.806923)
  overall=FAIL; similarity_score=65.0; 两页面整体结构相似，但顶部导航、邮件列表内容及顺序存在明显差异，影响用户体验一致性。
  suggestions=建议统一顶部导航栏结构，确保邮件列表顺序和内容一致性，特别是关键邮件（如广告、OpenAI）的展示逻辑。同时保持状态提示的位置和样式一致。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/11.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_EmailInboxList/elem2/after.jpeg (score=0.798359)
  overall=FAIL; similarity_score=65.0; 两页面整体结构相似，但关键组件如邮件列表顺序、标签页布局及广告展示存在明显差异，影响一致性体验。
  suggestions=建议统一标签页布局结构，确保邮件列表排序逻辑一致，并保持广告邮件的展示策略统一。同时注意头像图标风格的一致性。
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/10.jpg -> 11e8711f-2fe9-499f-8241-4307ffd90c14/reports/qqmail/20260523_015654/ability_EntryAbility_page_pages_EmailInboxList/init_screen.jpeg (score=0.787588)
  overall=FAIL; similarity_score=50.0; 两图整体结构差异明显，主要体现在顶部导航、侧边菜单及邮件列表内容上，无法视为大致相似。
  suggestions=确保顶部导航栏与参考图保持一致的布局和组件；检查是否正确触发了侧边菜单功能以匹配参考图中的文件夹视图；统一邮件列表的数据展示逻辑，保证关键信息的一致性。

## Unmatched References
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/14.png (page_id=app_settings; reason=no_runtime_candidate_for_page)
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/15.png (page_id=general_settings; reason=no_runtime_candidate_for_page)
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/7.jpg (page_id=settings_root; reason=no_runtime_candidate_for_page)
- 11e8711f-2fe9-499f-8241-4307ffd90c14/user_input/8.png (page_id=notification_guide; reason=no_runtime_candidate_for_page)
