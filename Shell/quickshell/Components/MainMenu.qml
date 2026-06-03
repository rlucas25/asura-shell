import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

PanelWindow {

    margins.top: 6

    signal closeRequested

    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore
    
    property bool isPlaying: {
        const playersList = Object.values(Mpris.players.values);
        if (playersList.length > 0) {
            return playersList[0].playbackState === "Playing";
        }
        return false;
    }
    
    anchors.top: true

    implicitWidth: 925
    implicitHeight: 375

    color: "transparent"

    Rectangle {
        
        anchors.fill: parent
        radius: 60
        color: "#383443"

        clip: true

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                implicitWidth: 70
                Layout.fillHeight: true
                topLeftRadius: 60
                bottomLeftRadius: 60

                color: '#4e4860'
            }

            Rectangle {
                id: circle
                implicitWidth: 150
                implicitHeight: 150

                anchors.top: parent.top
                anchors.left: parent.left
                
                anchors.topMargin: 50
                anchors.leftMargin: 100

                radius: 100
                color: "#4e4860"
                Text{
                    anchors{
                        centerIn: parent
                    }
                    font.pixelSize: 60

                    color: "#383443"
                    text: isPlaying ? "playing" : "󰎇"
                }
            }
            Rectangle {
                implicitWidth: 200
                implicitHeight: 200

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                anchors.topMargin: 30

                radius: 30
                color: "#4e4860"
            }
        }
    }

    RowLayout {
        spacing: 0
        anchors.margins: 4
        implicitHeight: 14
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Clock {}

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onExited: closeRequest()
            onClicked: closeRequested()
        }
    }
}
