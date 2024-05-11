import {TitleBar} from "../components/TitleBar";
enum Status {
    Ok,
    Done,
}

@Observed
class ListItem {
    static id: number = 0;
    public status: Status;
    public name: string;
    public id: string;

    constructor(name: string) {
        this.status = Status.Ok
        this.name = name
        this.id = ListItem.id.toString()
        ListItem.id++
    }
}

@Entry
@Component
export struct Todo {
    @State addShow: Visibility = Visibility.None;
    @State offsetY: number = 0;
    @State isTouching: boolean = false;
    @State list: Array<ListItem> = [];
    @State addInput: string = '';
    offTrigger: number = -65;
    deleteItem = (index: number): void => {
        this.list.splice(index, 1)
    }

    build() {
        Flex({direction: FlexDirection.Column}) {
            TitleBar({title: "Todo 页 标题"})
            Stack({ alignContent: Alignment.TopStart }) {
                Scroll() {
                    Column() {
                        Row() {
                            Text("下划新增")
                        }
                        .width(200)
                        .height(40)
                        .justifyContent(FlexAlign.Center)

                        ForEach(this.list, (item: ListItem, index: number) => {
                            ListItemComponent({
                                item: item,
                                index: index,
                                deleteItem: this.deleteItem
                            })
                        }, (item: ListItem) => item.id)
                    }
                    .width('100%')
                    .constraintSize({
                        minHeight: '100%'
                    })
                    .margin({ top: -10 })
                    .padding({ bottom: 20 })
                }
                .width('100%')
                .height('100%')
                .edgeEffect(EdgeEffect.Spring)
                .onScroll((_, offY) => {
                    if (this.isTouching) {
                        this.offsetY += offY
                    }
                })
                .onScrollStop(() => {
                    this.offsetY = 0;
                })
                .onTouch((e) => {
                    if (e.type === TouchType.Down) {
                        this.isTouching = true;
                    } else if (e.type === TouchType.Up) {
                        this.isTouching = false;
                        if (this.offsetY <= this.offTrigger) {
                            this.addShow = Visibility.Visible
                        }
                    }
                })

                AddBlock({
                    addInput: this.addInput,
                    addShow: this.addShow,
                    list: this.list,
                })
            }
        }
    }
}

@Component
struct ListItemComponent {
    @State origin: number = 0;
    @ObjectLink item: ListItem;
    @Prop index: number;
    offTrigger: number = 50;
    deleteItem: (i: number) => void = () => {
    };
    getDecorationType = (): TextDecorationType => {
        return this.item.status === Status.Ok ? TextDecorationType.None : TextDecorationType.LineThrough
    }
    getTip = (): string => {
        return this.item.status === Status.Ok ? '(右划完成)' : '(已完成，左划删除)'
    }

    build() {
        Column() {
            Text(this.item.name)
                .decoration({
                    type: this.getDecorationType()
                })
            Text(this.getTip())
        }
        .width(200)
        .height(100)
        .justifyContent(FlexAlign.Center)
        .border({
            width: 1,
            color: '#000'
        })
        .margin({
            top: 20
        })
        .onTouch((e) => {
            if (e.type === TouchType.Down) {
                this.origin = e.touches[0].windowX;
            } else if (e.type === TouchType.Move) {
                if (e.touches[0].windowX - this.origin >= this.offTrigger && this.item.status === Status.Ok) {
                    this.item.status = Status.Done
                } else if (this.origin - e.touches[0].windowX >= this.offTrigger && this.item.status === Status.Done) {
                    this.deleteItem(this.index)
                }
            }
        })
    }
}

@Component
struct AddBlock {
    @Link addInput: string;
    @Link addShow: Visibility;
    @Link list: Array<ListItem>;
    addList = () => {
        this.addShow = Visibility.None
        this.list.push(new ListItem(this.addInput))
        this.addInput = ''
    }

    build() {
        Column() {
            Row() {
                TextInput({ text: this.addInput })
                    .width(100)
                    .onChange((value: string) => {
                        this.addInput = value
                    })
                Button('添加').onClick(this.addList)
                Button('取消').backgroundColor("#fff").border({
                    width: 1,
                    color: '#000'
                }).fontColor('#000').onClick(() => {
                    this.addShow = Visibility.None
                    this.addInput = ''
                })
            }
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#fff')
        .visibility(this.addShow)
    }
}
