import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

interface Data {
    cardCount: number;
    page: number;
    pageCount: number;
    cards: Card[];
}

interface Card {
    image: string;
}

class HomeModel {
    data: Data;

    constructor(data?: Data) {
        this.data = data || {
            cardCount: 0,
            page: 1,
            pageCount: 1,
            cards: []
        };
    }
}

@Entry
@Component
export struct HomePage {
    @State data: HomeModel = new HomeModel();
    @State sheetHeight: number = 300;
    @State sheetShow: boolean = false;

    @Builder
    itemHead() {
        Flex({ alignItems: ItemAlign.Center }) {
            TextInput()
            Button({ type: ButtonType.Circle, stateEffect: true }) {
                SymbolGlyph($r("sys.symbol.slider_vertical_3"))
            }
            .width(55)
            .height(55)
            .margin({ left: 20 })
            .backgroundColor('white')
            .onClick(() => {
                this.sheetShow = true
            })
            .bindSheet(this.sheetShow,this.filter(), {
                height: this.sheetHeight
            })
        }
    }

    @Builder
    filter() {
        Text("弹框")
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
                ListItemGroup({ header: this.itemHead(), space: 20 }) {
                    ForEach(this.data.data.cards, (item: Card) => {
                        ListItem() {
                            Column() {
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
        }
        .width('100%')
        .height('100%')
        .backgroundColor(0xDCDCDC)
        .padding({ top: 5 })
    }
}