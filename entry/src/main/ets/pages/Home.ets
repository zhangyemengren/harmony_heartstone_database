import router from '@ohos.router'

@Component
export struct HomePage{
    @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()


    build(){
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