import { http } from '@kit.NetworkKit';

@Entry
@Component
export struct HomePage {
    private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    @Builder
    itemHead(text: string) {
        Text(text)
            .fontSize(20)
            .backgroundColor(0xAABBCC)
            .width("100%")
            .padding(10)
    }

    onPageShow() {
        console.log('IndexComponent onPageShow1');
        let httpRequest = http.createHttp();
        httpRequest.request(
            "http://www.baidu.com/"
        ).then((res: http.HttpResponse) => {
            console.info('code:' + JSON.stringify(res.responseCode));
            httpRequest.destroy();
        })
    }

    build() {
        Column() {
            List({ space: 20, initialIndex: 0 }) {
                ListItemGroup({ header: this.itemHead("header"), space: 20}){
                    ForEach(this.arr, (item: number) => {
                        ListItem() {
                            Text('' + item)
                                .width('100%')
                                .height(100)
                                .fontSize(16)
                                .textAlign(TextAlign.Center)
                                .borderRadius(10)
                                .backgroundColor(0xFFFFFF)
                        }
                    }, (item: string) => item)
                }
                .divider({
                    strokeWidth: 2,
                    color: 0xFFFFFF,
                    startMargin: 20,
                    endMargin: 20
                })
            }
            .width('90%')
            .sticky(StickyStyle.Header)
            .listDirection(Axis.Vertical) // 排列方向
            .scrollBar(BarState.Off)
            .friction(0.6)
            .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
            .onScrollIndex((firstIndex: number, lastIndex: number, centerIndex: number) => {
                console.info('first' + firstIndex)
                console.info('last' + lastIndex)
                console.info('center' + centerIndex)
            })
            .onScrollVisibleContentChange((start: VisibleListContentInfo, end: VisibleListContentInfo) => {
                console.log(' start index: ' + start.index +
                    ' start item group area: ' + start.itemGroupArea +
                    ' start index in group: ' + start.itemIndexInGroup)
                console.log(' end index: ' + end.index +
                    ' end item group area: ' + end.itemGroupArea +
                    ' end index in group: ' + end.itemIndexInGroup)
            })
            .onDidScroll((scrollOffset: number, scrollState: ScrollState) => {
                console.info(`onScroll scrollState = ScrollState` + scrollState + `, scrollOffset = ` + scrollOffset)
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(0xDCDCDC)
        .padding({ top: 5 })
    }
}