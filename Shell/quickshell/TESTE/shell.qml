import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.Widgets
import qs.Modules.Bar
import qs.Modules
import qs.Components
import qs.Asura

ShellRoot {
    id: root

    // IMPLEMENTAR OPÇÂO DE BARRA VERTICAl
    property bool verticalMode: false

    property real opacity: Config.ready ? Config.cfg.opacity : 1.0
    property real widthS: Config.ready ? Config.cfg.widthS : 7

    // 0: capsule mode | 1: float mode | 2: full mode
    property int barMode: Config.ready ? Config.cfg.barMode : 0
    property bool exclusiveMode: Config.ready ? Config.cfg.exclusiveMode : true

    property color backgroundColor: Config.ready ? Qt.color(Config.cfg.backgroundColor) : "#383443"
    property color foregroundColor: Config.ready ? Qt.color(Config.cfg.foregroundColor) : "#444b6a"
    property color color1: Config.ready ? Qt.color(Config.cfg.color1) : "#0db9d7"
    property color color2: Config.ready ? Qt.color(Config.cfg.color2) : "#ed7e4e"

    Bar {
        mode: root.barMode
        exclusiveMode: root.exclusiveMode
        background: Qt.alpha(root.backgroundColor, root.opacity)
        foreground: root.foregroundColor
        color1: root.color1
        color2: root.color2
        widthStages: widthS
    }

    Overlay {
        visible: root.barMode !== 0 && (opacity == 1.0) && (barMode == 2)
        bgColor: backgroundColor
    }

    VolumeOSD {
        verticalMode: root.verticalMode
        background: root.backgroundColor
        color1: root.color1
        color2: root.color2
    }



    Launcher {}
}
