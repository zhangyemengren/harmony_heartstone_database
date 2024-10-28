import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    console.log("onCreate")
  }

  onDestroy() {
    console.log("onDestroy")
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    console.log("onWindowStageCreate")

    windowStage.loadContent('pages/index', (err, data) => {
      if (err.code) {
        console.log("Failed to load the content. Cause:")
        return;
      }
      console.log("Succeeded in loading the content. Data:")
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    console.log("onWindowStageDestroy")
  }

  onForeground() {
    // Ability has brought to foreground
    console.log("onForeground")
  }

  onBackground() {
    // Ability has back to background
    console.log("onBackground")
  }
}
