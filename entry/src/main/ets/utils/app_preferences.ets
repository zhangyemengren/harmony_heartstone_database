import { preferences } from '@kit.ArkData';

export default class AppPreferences{
    static keyMap: Record<string, string> = {
        'API_HOST': 'API_HOST'
    }
    static getTest(ctx: Object){
        // let myPreferences: preferences.Preferences | null = null;
        let options: preferences.Options = { name: 'myStore' };
        let data = preferences.getPreferencesSync(getContext(ctx), options);
        let x = data.getSync('api', 'okok') as string;
        console.log(x);
    }
}