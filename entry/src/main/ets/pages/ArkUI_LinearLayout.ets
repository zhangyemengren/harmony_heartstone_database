import { TitleBar } from '../components/TitleBar';


@Component
@Preview
@Entry
export struct LinearLayout {
    scroller: Scroller = new Scroller();

    build() {
        Scroll(this.scroller) {
            Column() {
                TitleBar({ title: "ArkUI线性布局" })
                Column({ space: 20 }) {
                    Text('space: 20').fontSize(15).fontColor(Color.Gray).width('90%')
                    Row().width('90%').height(50).backgroundColor(0xF5DEB3)
                    Row().width('90%').height(50).backgroundColor(0xD2B48C)
                    Row().width('90%').height(50).backgroundColor(0xF5DEB3)
                }.width('100%')

                Row({ space: 35 }) {
                    Text('space: 35').fontSize(15).fontColor(Color.Gray)
                    Row().width('10%').height(150).backgroundColor(0xF5DEB3)
                    Row().width('10%').height(150).backgroundColor(0xD2B48C)
                    Row().width('10%').height(150).backgroundColor(0xF5DEB3)
                }.width('90%').margin({ top: 20 })

                Column({}) {
                    Text('Column子元素在水平方向左对齐').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .backgroundColor('rgb(242,242,242)')
                .margin({ top: 20 })

                Column({}) {
                    Text('Column子元素在水平方向居中').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('rgb(242,242,242)')
                .margin({ top: 20 })

                Column({}) {
                    Text('Column子元素在水平方向右对齐').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }.width('100%').alignItems(HorizontalAlign.End).backgroundColor('rgb(242,242,242)').margin({ top: 20 })

                Row({}) {
                    Text('Row子元素在垂直方向顶部对齐').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .alignItems(VerticalAlign.Top)
                .backgroundColor('rgb(242,242,242)')
                .margin({ top: 20 })

                Row({}) {
                    Text('Row子元素在垂直方向居中对齐').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .alignItems(VerticalAlign.Center)
                .backgroundColor('rgb(242,242,242)')
                .margin({ top: 20 })

                Row({}) {
                    Text('Row子元素在垂直方向底部对齐').fontSize(15).fontColor(Color.Gray)
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .alignItems(VerticalAlign.Bottom)
                .backgroundColor('rgb(242,242,242)')
                .margin({ top: 20 })

                Text('Column 各个FlexAlign效果').fontSize(15).fontColor(Color.Gray).margin({ top: 20 })

                Column({}) {
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(300)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.Start)
                .margin({ top: 20 })

                Column({}) {
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(300)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.Center)
                .margin({ top: 20 })

                Column({}) {
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(300)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.End)
                .margin({ top: 20 })

                Column({}) {
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(300)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.SpaceAround)
                .margin({ top: 20 })

                Column({}) {
                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('80%').height(50).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(300)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.SpaceEvenly)
                .margin({ top: 20 })

                Text('Row 各个FlexAlign效果').fontSize(15).fontColor(Color.Gray).margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.Start)
                .margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.End)
                .margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.Center)
                .margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.SpaceAround)
                .margin({ top: 20 })

                Row({}) {
                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xD2B48C)

                    Column() {
                    }.width('20%').height(30).backgroundColor(0xF5DEB3)
                }
                .width('100%')
                .height(200)
                .backgroundColor('rgb(242,242,242)')
                .justifyContent(FlexAlign.SpaceEvenly)
                .margin({ top: 20 })

                Text('自适应拉伸').fontSize(15).fontColor(Color.Gray).margin({ top: 20 })
                Column() {
                    Row() {
                        Text('Bluetooth').fontSize(18)
                        Blank()
                        Toggle({ type: ToggleType.Switch, isOn: true })
                    }.backgroundColor(0xFFFFFF).borderRadius(15).padding({ left: 12 }).width('100%')
                }.backgroundColor(0xEFEFEF).padding(20).width('100%').margin({ top: 20 })

                Column() {
                    Text('1:2:3').width('100%')
                    Row() {
                        Column() {
                            Text('layoutWeight(1)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(1).backgroundColor(0xF5DEB3).height('100%')

                        Column() {
                            Text('layoutWeight(2)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(2).backgroundColor(0xD2B48C).height('100%')

                        Column() {
                            Text('layoutWeight(3)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(3).backgroundColor(0xF5DEB3).height('100%')

                    }.backgroundColor(0xffd306).height('30%')

                    Text('2:5:3').width('100%').margin({ top: 20 })
                    Row() {
                        Column() {
                            Text('layoutWeight(2)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(2).backgroundColor(0xF5DEB3).height('100%')

                        Column() {
                            Text('layoutWeight(5)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(5).backgroundColor(0xD2B48C).height('100%')

                        Column() {
                            Text('layoutWeight(3)')
                                .textAlign(TextAlign.Center)
                        }.layoutWeight(3).backgroundColor(0xF5DEB3).height('100%')
                    }.backgroundColor(0xffd306).height('30%')
                }

                Text("自适应延伸 基本为滚动条效果").margin({top: 20})
            }.width('100%')
        }.edgeEffect(EdgeEffect.Spring)
    }
}