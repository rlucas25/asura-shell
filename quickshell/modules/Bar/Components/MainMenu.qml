import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    visible: osdVisible
    margins.top: 6

    signal closeRequested

    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore

    anchors.top: true

    implicitWidth: 800
    implicitHeight: 400

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
                implicitWidth: 150
                implicitHeight: 150

                anchors.top: parent.top
                anchors.left: parent.left
                
                anchors.topMargin: 50
                anchors.leftMargin: 100

                radius: 100
                color: "#4e4860"
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

            onClicked: closeRequested()
        }
    }
}
