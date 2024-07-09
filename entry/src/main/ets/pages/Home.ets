import router from '@ohos.router'

@Component
@Preview
export struct HomePage{
    @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()


    build(){
        Column(){
            Button(){
                Text("go to do list")
            }
            .width(200)
            .height(50)
            .onClick(() => {
                router.pushUrl({
                    url: "pages/Todo"
                })
            })
        }

    }
}