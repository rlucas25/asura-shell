import Quickshell
import Quickshell.Wayland
import QtQuick

Text {
    font {
        pixelSize: 14
        family: "JetBrainsMono Nerd Font Propo"
    }

    property string currentTime: ""

    text: currentTime
    color: "#0db9d7"

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            var now = new Date();
            currentTime = Qt.formatTime(now);
        }
    }

    Component.onCompleted: {
        var now = new Date();
        currentTime = Qt.formatTime(now);
    }
}
