import router from '@ohos.router';

@Entry
@Component
struct Index {
  aboutToAppear() {
    try {
      router.replaceUrl({ url: 'pages/SidebarNavigation' })
    } catch (error) {
      console.error('Index redirect failed:', JSON.stringify(error));
    }
  }
  build() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
  }
}
