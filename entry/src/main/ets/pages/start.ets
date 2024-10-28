import router from '@ohos.router';

@Entry
@Component
struct StartPage{


    aboutToAppear(){
        setTimeout(() => {
            router.replaceUrl({
                url: "pages/Index"
            })
        }, 3000)
    }
    build(){
        Row(){
            Text("这是启动页，三秒后跳转首页")
        }
    }
}