import router from '@ohos.router'

@Preview
@Component
export struct TitleBar{
    private title:string = "默认标题";
    build(){
        Row(){
            Button(){
                Text("后退")
            }
            .onClick(() => {
                router.back()
            })
            Text(this.title)
        }
        .height(50)
    }
}