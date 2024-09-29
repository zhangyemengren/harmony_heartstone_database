import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { LengthMetrics } from '@kit.ArkUI';
import {Response} from '../../data/response';

interface Data {
    cardCount: number;
    page: number;
    pageCount: number;
    cards: Card[];
}

interface Meta{
    classes: Classes[];
}
interface Classes{
    name: string;
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
    header() {
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
            .bindSheet($$this.sheetShow, this.filter(), {
                height: this.sheetHeight,
                showClose: false
            })
        }
    }

    @Builder
    filterItem(list: number[]){
        Column(){
            Text("职业")
            Flex({wrap: FlexWrap.Wrap, space: {main: LengthMetrics.vp(5), cross: LengthMetrics.vp(5)}}){
                ForEach(list, (item: number) => {
                    Button("文案" ,{})
                        .backgroundColor(Color.Transparent)
                        .border({width:1, color: Color.Black})
                        .fontColor(Color.Black)
                }, (item: string) => item)
            }
            .height('auto')
            .width("90%")
            .border({ width: 3, color: Color.Red })
        }
    }

    @Builder
    filter() {
        Scroll() {
            Column() {
                Row(){
                    Text("bar")
                }
                .width(50)
                .height(20)
                .backgroundColor(Color.Green)
                .draggable(true)
                .onDragStart((e:DragEvent) => {
                    console.info(e.getWindowX() + 'oy')
                })
                .onClick(() => {
                    console.error("dayin")
                })
                Text("筛选项")
                this.filterItem([1,2,3])

                this.filterItem([1,2,3,4,5,6,7])
            }
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
    }

    onPageShow() {
        console.log('IndexComponent onPageShow1');
        let httpRequest = http.createHttp();
        // httpRequest.request(
        //     "http://localhost:8000/cards"
        // ).then((res: http.HttpResponse) => {
        //     const data = res.result as string;
        //     this.data = new HomeModel(JSON.parse(data));
        //     httpRequest.destroy();
        // }).catch((err: BusinessError) => {
        //     console.error('error:' + JSON.stringify(err));
        // })
        httpRequest.request(
            "http://localhost:8000/meta",
            {
                expectDataType: http.HttpDataType.STRING,
                header: {'Content-Type': 'application/json' },
            }
        ).then((res: http.HttpResponse) => {
            const data = res.result as string;
            const d:Response<Meta> = JSON.parse(data);
            const firstName:string = d.data.classes[0].name;
            console.log(firstName);
            httpRequest.destroy();
        }).catch((err: BusinessError) => {
            console.error('error:' + JSON.stringify(err));
        })
    }

    build() {
        Column() {
            List({ space: 20, initialIndex: 0 }) {
                ListItemGroup({ header: this.header(), space: 20 }) {
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
            .listDirection(Axis.Vertical)
            .scrollBar(BarState.Off)
            .friction(0.6)
            .edgeEffect(EdgeEffect.Spring)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(0xDCDCDC)
        .padding({ top: 5 })
    }
}