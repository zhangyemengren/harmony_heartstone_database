import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { LengthMetrics, window, router } from '@kit.ArkUI';
import BuildProfile from 'entry/BuildProfile';
import { Float } from '../../components/float';
import { Response } from '../../data/response';
import AppPreferences from '../../utils/app_preferences';
import { PREVIEWER_DEFAULT_HEIGHT, PREVIEWER_DEFAULT_WIDTH, TAB_HEIGHT } from '../../data/system';

interface Data {
    cardCount: number;
    page: number;
    pageCount: number;
    cards: Card[];
    classes: Filter[];
}

interface MetaData {
    classes: Filter[];
    rarities: Filter[];
    types: Filter[];
    sets: Filter[];
    // setGroups
}

interface CardData {
    cards: Card[];
    cardCount: number;
    page: number;
    pageCount: number;
}

interface Filter {
    id: number;
    name: string;
}

interface Card {
    image: string;
}

class HomeModel {
    classes: Filter[];
    rarities: Filter[];
    types: Filter[];
    cards: Card[];

    constructor(data?: Data) {
        this.classes = data?.classes || [];
        this.cards = data?.cards || [];
        this.rarities = [];
        this.types = [];
    }
}

@Entry
@Component
export struct HomePage {
    @State data: HomeModel = new HomeModel();
    @State sheetHeight: number = 300;
    @State sheetShow: boolean = false;
    @State windowHeight: number = 0;
    @State isDebugMode: boolean = BuildProfile.DEBUG;
    @State containerWidth: number = 0;
    @State containerHeight: number = 0;

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
    filterItem(title: string, list: Filter[]) {
        Column() {
            Text(title)
            Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(5), cross: LengthMetrics.vp(5) } }) {
                ForEach(list, (item: Filter) => {
                    Button(item.name, {})
                        .backgroundColor(Color.Transparent)
                        .border({ width: 1, color: Color.Black })
                        .fontColor(Color.Black)
                }, (item: Filter) => `${item.id}`)
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
                Row() {
                    Text("bar")
                }
                .width(50)
                .height(20)
                .backgroundColor(Color.Green)
                .onTouch((e: TouchEvent) => {
                    e.stopPropagation();
                    switch (e.type) {
                        case TouchType.Move: {
                            const yEnd = e.touches[0].y;
                            console.log(yEnd + '');
                        }
                    }
                })

                Text("筛选项")
                this.filterItem("职业", this.data.classes)
                this.filterItem("类型", this.data.types)
                this.filterItem("稀有度", this.data.rarities)
            }
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
    }

    aboutToAppear() {
        console.log('IndexComponent aboutToAppear');
        window.getLastWindow(getContext(this)).then((data) => {
            // 系统默认区域
            const arect = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
            // 刘海屏区域
            const arect2 = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT)
            // 屏幕区域
            const prect = data.getWindowProperties()
            // 大致计算 屏幕区域 - 不可用区域 再单位换算
            // preview 时无法获取getWindowAvoidArea信息 给出大概默认值
            this.containerWidth = px2vp(prect.windowRect.width || PREVIEWER_DEFAULT_WIDTH);
            this.containerHeight = px2vp(
                prect.windowRect.height -
                arect.topRect.height -
                arect.bottomRect.height -
                arect2.topRect.height
                    || PREVIEWER_DEFAULT_HEIGHT
            ) - TAB_HEIGHT;
        })

        // 请求
        let httpRequest = http.createHttp();
        const baseUrl = new AppPreferences(this).get(AppPreferences.keyMap.API_HOST).toString();
        httpRequest.request(
            `${baseUrl}cards`
        ).then((res: http.HttpResponse) => {
            const data = res.result as string;
            const d: Response<CardData> = JSON.parse(data);
            this.data.cards = d.data.cards;
        }).catch((err: BusinessError) => {
            console.error('error:' + JSON.stringify(err));
        }).finally(() => {
            httpRequest.destroy();
        })
        let httpRequest2 = http.createHttp();
        httpRequest2.request(
            `${baseUrl}meta`,
            {
                expectDataType: http.HttpDataType.STRING,
                header: { 'Content-Type': 'application/json' },
            }
        ).then((res: http.HttpResponse) => {
            const data = res.result as string;
            const d: Response<MetaData> = JSON.parse(data);
            this.data.classes = d.data.classes;
            this.data.rarities = d.data.rarities;
            this.data.types = d.data.types;
        }).catch((err: BusinessError) => {
            console.log(`需要改成ip${baseUrl}`)
            console.error('error:' + JSON.stringify(err));
        }).finally(() => {
            httpRequest2.destroy();
        })
    }

    onPageShow(): void {
        console.log('onPageShow')
    }


    build() {
        Stack() {
            Column() {
                List({ space: 20, initialIndex: 0 }) {
                    ListItemGroup({ header: this.header(), space: 20 }) {
                        ForEach(this.data.cards, (item: Card) => {
                            ListItem() {
                                Column() {
                                    Image(item.image)
                                        .width(40)
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

            if (this.isDebugMode) {
                Float({ containerWidth: this.containerWidth, containerHeight: this.containerHeight }) {
                    Button({ type: ButtonType.Circle, stateEffect: true }) {
                        SymbolGlyph($r("sys.symbol.gearshape"))
                            .fontSize(30)
                    }
                    .width(55)
                    .height(55)
                    .onClick(() => {
                        console.log('123456')
                        try {
                            router.pushUrl({
                                url: 'pages/dev_env/index'
                            }).then(() => {
                                console.log('then')
                            }).catch((err: BusinessError) => {
                                console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
                            })
                        }catch (err){
                            console.error(`pushUrl failed, code is ${(err as BusinessError).code}, message is ${(err as BusinessError).message}`);
                        }
                    })
                }
            }
        }
    }
}