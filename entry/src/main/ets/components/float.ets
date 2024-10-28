import { curves } from '@kit.ArkUI';


export class Constants {
    static readonly PAGE_PADDING: number = 12; // 页面内容内边距，用于悬浮窗位置计算
    static readonly INIT_POSITION_Y: number = 300; // 悬浮窗相对父容器左上角的Y坐标初始值
}

@Preview
@Component
export struct Float {
    @Builder closerBuilder(){};
    @BuilderParam children: () => void = this.closerBuilder;
    @State edge: Edges = { top: Constants.INIT_POSITION_Y, right: Constants.PAGE_PADDING };
    @State componentWidth: number = 0;
    @State componentHeight: number = 0;
    @Link containerWidth: number;
    @Link containerHeight: number;
    private windowStartX: number = 0;
    private windowStartY: number = 0;

    onTouchEvent(event: TouchEvent): void {
        switch (event.type) {
            case TouchType.Down: {
                // 获取拖拽开始时悬浮窗在窗口中的坐标
                this.windowStartX = event.touches[0].windowX;
                this.windowStartY = event.touches[0].windowY;
                break;
            }
            case TouchType.Move: {
                const windowX: number = event.touches[0].windowX;
                const windowY: number = event.touches[0].windowY;
                // TODO：知识点：跟手动画，推荐使用默认参数的弹性跟手动画曲线curves.responsiveSpringMotion。
                animateTo({ curve: curves.responsiveSpringMotion() }, () => {
                    // 判断当前edge中属性left和right哪个不为undefined，用于控制悬浮窗水平方向的位置
                    if (this.edge.left !== undefined) {
                        this.edge.left = this.edge.left as number + (windowX - this.windowStartX);
                    } else {
                        this.edge.right = this.edge.right as number - (windowX - this.windowStartX);
                    }
                    this.edge.top = this.edge.top as number + (windowY - this.windowStartY);
                    this.windowStartX = windowX;
                    this.windowStartY = windowY;
                })
                break;
            }
            case TouchType.Up: {
                // 计算悬浮窗中心点在父组件中水平方向的坐标
                let centerX: number;
                if (this.edge.left !== undefined) {
                    centerX = this.edge.left as number + this.componentWidth / 2;
                } else {
                    centerX = this.containerWidth - (this.edge.right as number) - this.componentWidth / 2;
                }
                // TODO：知识点：通过判断悬浮窗在父组件中的位置，设置悬浮窗贴边，使用curves.springMotion()弹性动画曲线，可以实现阻尼动画效果
                animateTo({ curve: curves.springMotion() }, () => {
                    // 判断悬浮窗中心在水平方向是否超过父组件宽度的一半，根据结果设置靠左或靠右
                    if (centerX > (this.containerWidth / 2)) {
                        this.edge.right = Constants.PAGE_PADDING;
                        this.edge.left = undefined;
                    } else {
                        this.edge.right = undefined;
                        this.edge.left = Constants.PAGE_PADDING;
                    }
                    // 判断悬浮窗是否超出内容区上下边界，根据结果将悬浮窗设置在边界位置
                    if (this.edge.top as number < Constants.PAGE_PADDING) {
                        this.edge.top = Constants.PAGE_PADDING;
                    } else if (this.edge.top as number >
                        this.containerHeight - this.componentHeight - Constants.PAGE_PADDING) {
                        this.edge.top = this.containerHeight - this.componentHeight - Constants.PAGE_PADDING;
                    }
                })
                break;
            }
            default: {
                break;
            }
        }
    }

    build() {
        Column(){
            this.children()
        }
        .position(this.edge)
        .onTouch((event: TouchEvent) => {
            this.onTouchEvent(event);
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
           if (oldValue.width !== newValue.width){
               this.componentWidth = newValue.width as number;
           }
           if (oldValue.height !== newValue.height){
               this.componentHeight = newValue.height as number;
           }
        })
    }
}