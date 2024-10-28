import AppPreferences from '../../utils/app_preferences';

@Entry
@Component
export struct DevEnv{
    build() {
        Column(){
            Row(){
                Text("api地址")
                TextInput()
            }
            Row(){
                Button("保存").onClick(() => {
                    AppPreferences.getTest(this)
                })
            }
        }
    }
}