import {TitleBar} from "../components/TitleBar";


@Component
@Preview
@Entry
export struct HomePage{
    @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()


    build(){
        Column(){
            TitleBar({title: "ArkUI_LinearLayout"})

        }.height("100%")

    }
}