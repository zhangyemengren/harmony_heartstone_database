import { preferences } from '@kit.ArkData';

export default class AppPreferences{
    static keyMap: Record<string, string> = {
        'API_HOST': 'API_HOST'
    }
    static DEFAULT_VALUES: Record<string, preferences.ValueType> = {
        'API_HOST': 'http://localhost:8000'
    }
    static getDefaultValue(key: string) {
        return AppPreferences.DEFAULT_VALUES[key];
    }
    ctx: Object;

    constructor(ctx: Object) {
        this.ctx = ctx;
    }
    getPreference(): preferences.Preferences{
        let options: preferences.Options = { name: 'myStore' };
        let data = preferences.getPreferencesSync(getContext(this.ctx), options);
        return data;
    }
    get(key: string, defaultValue?: string): preferences.ValueType{
        const data = this.getPreference();
        return data.getSync(key, defaultValue || AppPreferences.getDefaultValue(key));
    }
    put(key: string, value: preferences.ValueType){
        const data = this.getPreference();
        data.putSync(key, value);
    }
    flush(){
        const data = this.getPreference();
        data.flush();
    }
}