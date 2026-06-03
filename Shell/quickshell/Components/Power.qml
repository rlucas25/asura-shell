import Quickshell
import Quickshell.Wayland
import QtQuick

Item {
    implicitWidth: power.implicitWidth
    implicitHeight: power.implicitHeight

    Text {
        id: power
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }
        text: "⏻"
        color: "#0db9d7"
    }
    
}
