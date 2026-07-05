import Quickshell
import Quickshell.Wayland
import QtQuick

Item {
    implicitWidth: power.implicitWidth
    implicitHeight: power.implicitHeight
    property color color1

    Text {
        id: power
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }
        text: "⏻"
        color: color1
    }
    
}
