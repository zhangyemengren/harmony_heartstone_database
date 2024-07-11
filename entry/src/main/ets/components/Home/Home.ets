import { http } from '@kit.NetworkKit';

@Entry
@Component
export struct HomePage {
    onPageShow(){
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
            Row() {
                Text('本周精选')
                    .fontSize(20)
                    .fontColor(Color.White)
                    .width('100%')
                    .textAlign(TextAlign.Center)
                    .padding({ top: 30, bottom: 60 })
            }.alignItems(VerticalAlign.Top)
            .backgroundColor(0x007dfe)
            .height("100%")
        }
    }
}