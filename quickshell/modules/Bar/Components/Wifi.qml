import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

Text {
    font {
        pixelSize: 14
        family: "JetBrainsMono Nerd Font"
    }

    property int wifiSignal: 0
    property bool hoverEnabled: false
    property bool opened: false

    Process {
        id: wifiProc

        command: ["sh", "-c", "nmcli -t -f ACTIVE,SIGNAL dev wifi | grep '^yes' | cut -d: -f2"]

        stdout: StdioCollector {
            onStreamFinished: {
                wifiSignal = parseInt(this.text.trim()) || 0;
            }
        }
    }
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: wifiProc.running = true
    }

    property string icon: {
        switch (true) {
        case wifiSignal >= 80:
            return "󰤨";
            break;
        case wifiSignal >= 60:
            return "󰤥";
            break;
        case wifiSignal >= 40:
            return "󰤢";
            break;
        case wifiSignal >= 10:
            return "󰤟";
            break;
        default:
            return "󰤯";
            break;
        }
    }

    text: opened ? icon + " " + wifiSignal + "%" : icon
    color: "#0db9d7"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: opened = true
        onExited: opened = false
    }
}
