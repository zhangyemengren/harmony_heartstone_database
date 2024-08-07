import {TAB_GROUP} from "../data/TabConfig";
import { TabItems } from '../types/DataType';
import {HomePage} from "./Home/Index";

@Builder
function TabContentItem(index: number) {
    Column() {
        Text(`Tab Content${index + 1}`)
            .fontSize(36)
            .fontColor('#182431')
            .fontWeight(500)
            .opacity(0.4)
            .margin({ top: 30, bottom: 56.5 })
        Divider()
            .strokeWidth(0.5)
            .color('#182431')
            .opacity(0.05)
    }.width('100%')
}

// xxx.ets
@Entry
@Component
struct TabEntry {
    @State currentIndex: number = 0
    @State tabList:TabItems[] = TAB_GROUP
    private controller: TabsController = new TabsController()
    // pageInfos: NavPathStack = new NavPathStack()

    @Builder
    tabBuilder(item: TabItems, index: number) {
        Column() {
            Image(this.currentIndex === index ? item.iconActive : item.icon)
                .width(24)
                .height(24)
                .margin({ bottom: 4 })
                .objectFit(ImageFit.Contain)
            Text(item.name)
                .fontColor(this.currentIndex === index ? $r("app.color.main") : $r("app.color.text_color"))
                .fontSize(10)
                .fontWeight(500)
                .lineHeight(14)
        }.width('100%')
    }

    build() {
        Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
            ForEach(this.tabList, (item: TabItems, index: number) => {
                TabContent() {
                    if (index === 0){
                        HomePage()
                    } else {
                        TabContentItem(index)
                    }
                }.tabBar(this.tabBuilder(item, index))
            })
        }
        .vertical(false)
        .barHeight(56)
        .scrollable(false) //防止滑动页面切换
        .backgroundColor('#F1F3F5')
        .animationDuration(0) // 停用切换动画
        .onChange((index: number) => {
            this.currentIndex = index
        })

    }
}