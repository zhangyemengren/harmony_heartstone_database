import router from '@ohos.router';

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
struct Index {
    @State addShow: Visibility = Visibility.None;
    @State offsetY: number = 0;
    @State isTouching: boolean = false;
    @State list: Array<ListItem> = [];
    @State addInput: string = '';
    private offTrigger: number = -65;

    build() {
        Stack({ alignContent: Alignment.TopStart }) {
            Scroll() {
                Column() {
                    Row() {
                        Text("下划新增")
                    }
                    .width(200)
                    .height(40)
                    .justifyContent(FlexAlign.Center)

                    ForEach(this.list, (item, index) => {
                        ListItemComponent({
                            item,
                            deleteItem: this.deleteItem.bind(null, index)
                        })
                    }, (item) => item.id)
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
                addInput: $addInput,
                addShow: $addShow,
                list: $list,
            })
        }
        .width('100%')
        .height('100%')
    }

    public  deleteItem = (index: number) => {
        this.list.splice(index, 1)
    }
}

@Component
struct ListItemComponent {
    @ObjectLink item: ListItem;
    @State origin: number = 0;
    deleteItem: () => {};
    private offTrigger: number = 50;

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
                this.origin = e.touches[0].screenX;
            } else if (e.type === TouchType.Move) {
                if (e.touches[0].screenX - this.origin >= this.offTrigger && this.item.status === Status.Ok) {
                    this.item.status = Status.Done
                } else if (this.origin - e.touches[0].screenX >= this.offTrigger && this.item.status === Status.Done) {
                    this.deleteItem()
                }
            }
        })
    }

    private getDecorationType = (): TextDecorationType => {
        return this.item.status === Status.Ok ? TextDecorationType.None : TextDecorationType.LineThrough
    }

    private getTip = (): string => {
        return this.item.status === Status.Ok ? '(右划完成)' : '(已完成，左划删除)'
    }
}

@Component
struct AddBlock {
    @Link addInput: string;
    @Link addShow: Visibility;
    @Link list: Array<ListItem>;

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

    private addList = () => {
        this.addShow = Visibility.None
        this.list.push(new ListItem(this.addInput))
        this.addInput = ''
    }
}
