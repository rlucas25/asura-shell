import Quickshell
import QtQuick
import Quickshell.Io

Item {
    implicitWidth: volume.implicitWidth
    implicitHeight: volume.implicitHeight

    property color color1
    property color color2

    property int volumeLevel: 0
    property bool hovered: false
    property bool showPercent: false
    property bool muted: false

    Process {
        id: volProc

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                let match = data.match(/Volume:\s*([\d.]+)/);

                if (match) {
                    let newVolume = Math.round(parseFloat(match[1]) * 100);

                    if (newVolume !== volumeLevel) {
                        volumeLevel = newVolume;

                        showPercent = true;
                        hideTimer.restart();
                    }
                }

                muted = data.includes("[MUTED]");
            }
        }
    }

    Process {
        id: muteProc

        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    }

    Timer {
        interval: 100
        running: true
        repeat: true

        onTriggered: {
            volProc.running = true;
        }
    }

    Timer {
        id: hideTimer

        interval: 500
        repeat: false

        onTriggered: {
            if (!hovered)
                showPercent = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            hovered = true;
            showPercent = true;
        }

        onExited: {
            hovered = false;
            hideTimer.restart();
        }

        onClicked: {
            muteProc.running = true;

            showPercent = true;
            hideTimer.restart();
        }
    }

    Text {
        id: volume

        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }

        property string icon: {
            if (muted || volumeLevel === 0)
                return "";

            if (volumeLevel >= 60)
                return "";

            return "";
        }

        text: showPercent ? icon + " " + volumeLevel + "%" : icon

        color: muted ? color2 : color1
    }
}
