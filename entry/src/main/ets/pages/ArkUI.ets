import {TitleBar} from "../components/TitleBar";
import router from '@ohos.router'

@Component
@Preview
@Entry
export struct HomePage{
    @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()


    build(){
        Column(){
            TitleBar({title: "ArkUI"})
            Button(){
                Text("线性布局")
            }
            .width(200)
            .height(50)
            .onClick(() => {
                router.pushUrl({
                    url: "pages/ArkUI_LinearLayout"
                })
            })
        }.height("100%")

    }
}