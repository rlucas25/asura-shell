import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Layouts

PanelWindow {
    property int volumeLevel: 0
    property bool muted: false
    property bool show

    visible: true
    width: 50
    height: 250
    color: "transparent"

    Process {
        id: volProc

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: SplitParser {
            onRead: data => {
                console.log("DATA =", data);

                let match = data.match(/Volume:\s*([\d.]+)/);

                console.log("MATCH =", match);

                if (match) {
                    let newVolume = Math.round(parseFloat(match[1]) * 100);

                    console.log("VOLUME =", newVolume);

                    volumeLevel = newVolume;
                }
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: '#a3000000'
        radius: 20
        anchors.centerIn: parent
        clip: true

        Rectangle {
            width: parent.width
            height: parent.height * volumeLevel / 100
            radius: parent.radius
            anchors.bottom: parent.bottom
            color: "gray"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 40
            text: volumeLevel + "%"
            color: "white"
        }
    }
    Timer {
        id: hideTimer
        interval: 2000
        repeat: false
        running: false
        onTriggered: show = false
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: volProc.start()
    }
}
