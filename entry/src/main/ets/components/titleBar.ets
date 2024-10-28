import router from '@ohos.router';

@Preview
@Component
export struct TitleBar {
    private title: string = "默认标题";

    build() {
        Row() {
            Image($r('sys.symbol.backward_end_fill'))
                .width(24)
                .height(24)
                .margin({ bottom: 4 })
                .objectFit(ImageFit.Contain)
                .onClick(() => {
                    router.back()
                })

            Text(this.title)
        }
        .width('100%')
        .height(50)
        .padding({left: 20})
    }
}