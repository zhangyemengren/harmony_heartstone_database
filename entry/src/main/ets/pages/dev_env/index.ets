import AppPreferences from '../../utils/app_preferences';
import { TitleBar } from '../../components/title_bar';
import {router} from '@kit.ArkUI';

@Entry
@Component
export struct DevEnv {
    @State api: string = '';
    store = new AppPreferences(this);
    onSave = () => {
        console.log(this.api)
        this.store.put(AppPreferences.keyMap.API_HOST, this.api);
        this.store.flush();
        router.back();
    }

    aboutToAppear(): void {
        const api = this.store.get(AppPreferences.keyMap.API_HOST);
        this.api = api.toString();
    }

    build() {
        Column() {
            TitleBar()
            Row() {
                Text("api地址")
                TextInput({
                    text: this.api
                })
                    .onChange((v: string) => {
                        this.api = v;
                    })
            }

            Row() {
                Button("保存").onClick(this.onSave)
            }
        }
    }
}