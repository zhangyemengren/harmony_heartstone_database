import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

interface Data{
    cardCount:number;
    page: number;
    pageCount: number;
    cards: Card[];
}
interface Card{
    image: string;
}

class HomeModel{
    data: Data;
    constructor(data?: Data) {
        this.data = data || {cardCount:0, page: 1, pageCount: 1, cards: []};
    }
}
@Entry
@Component
export struct HomePage {
    @State private data: HomeModel = new HomeModel();

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
            "http://localhost:8000/cards"
        ).then((res: http.HttpResponse) => {
            const data = res.result as string;
            this.data = new HomeModel(JSON.parse(data));
            httpRequest.destroy();
        }).catch((err: BusinessError) => {
            console.error('error:' + JSON.stringify(err));
        })
    }

    build() {
        Column() {
            List({ space: 20, initialIndex: 0 }) {
                ListItemGroup({ header: this.itemHead("header"), space: 20}){
                    ForEach(this.data.data.cards, (item: Card) => {
                        ListItem() {
                            Column(){
                                Text('' + item.image)
                                    .width('100%')
                                    .height(100)
                                    .fontSize(16)
                                    .textAlign(TextAlign.Center)
                                    .borderRadius(10)
                                    .backgroundColor(0xFFFFFF)
                                Image(item.image)
                            }
                        }
                    }, (item: Card) => item.image)
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