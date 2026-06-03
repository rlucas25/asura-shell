import Quickshell
import QtQuick
import Quickshell.Wayland
import "Widgets" as WG

ShellRoot {
    id: root

    property real opacity: Config.ready ? Config.cfg.opacity : 1.0
    property real widthS: Config.ready ? Config.cfg.widthS : 7

    // 0: capsules mode | 1: float mode | 2: full mode
    property int barMode: Config.ready ? Config.cfg.barMode : 2
        
    property color backgroundColor: Config.ready ? Qt.color(Config.cfg.backgroundColor) : "#383443"
    property color color1: Config.ready ? Qt.color(Config.cfg.color1) : "#0db9d7"
    property color color2: Config.ready ? Qt.color(Config.cfg.color2) : "#ed7e4e"
    
    WG.Bar {
        mode: root.barMode
        background: Qt.alpha(backgroundColor, opacity)
        color1: root.color1
        color2: root.color2
        widthStages: widthS
    }
    
    WG.Overlay {
        visible: root.barMode !== 0 && (opacity == 1.0) && (barMode == 2)
        bgColor: backgroundColor
    }

    //WG.VolumeOSD {}
}
