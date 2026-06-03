import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

Text {
    font {
        pixelSize: 14
        family: "JetBrainsMono Nerd Font Propo"
    }

    property int wifiSignal: 0
    property string wifiName: ""
    property bool hoverEnabled: false
    property bool hovered: false
    property bool opened: false

    Process {
        id: wifiProc

        command: ["sh", "-c", 
            "nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep '^yes'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(":")

                wifiName = parts[1] || ""
                wifiSignal = Number(parts[2]) || 0;
            }
        }
    }
    Timer {
        id: processTimer
        interval: 3000
        running: true
        repeat: true
        onTriggered: wifiProc.running = true
    }

    Timer {
        id: hideTimer

        interval: 500
        repeat: false

        onTriggered: {
            if (!hovered)
                opened = false
        }
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

    property string hoverOutput: {
        if (wifiSignal == 0) {
            return icon + " " + wifiSignal + "%";
        }
        else{
            return icon + " " + wifiSignal + "%" + " " + wifiName + " ";
        }
    }
    
    text: opened? hoverOutput : icon
    color: "#0db9d7"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: opened = true
        onExited: {  
            hovered = false
            hideTimer.restart()
        }
    }
}
