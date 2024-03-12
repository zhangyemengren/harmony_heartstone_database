import router from '@ohos.router';

@Entry
@Component
struct Index {
    @State message: string = 'Hello World'

    build() {
        Row() {
            Column() {
                Text(this.message)
                    .fontSize(50)
                    .fontWeight(FontWeight.Bold)
                Button() {
                    Text('Next1').fontSize(30).fontWeight(FontWeight.Bold)
                }
                .type(ButtonType.Capsule)
                .margin({
                    top: 20
                })
                .backgroundColor('#0D9FFB')
                .width('40%')
                .height('10%')
                .onClick(() => {
                    console.info(`Succeeded in clicking the 'Next' button.`)
                    // 跳转到第二页
                    router.pushUrl({ url: 'pages/Second' }).then(() => {
                        console.info('Succeeded in jumping to the second page.')
                    }).catch((err) => {
                        console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
                    })
                })
            }
            .width('100%')
        }
        .height('100%')
    }
}