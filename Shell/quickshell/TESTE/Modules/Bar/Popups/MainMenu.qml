import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "../Widgets"

Rectangle {

    
    property color background
    property color color1
    
    radius: 60
    color: background

    clip: true

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            implicitWidth: 70
            Layout.fillHeight: true
            topLeftRadius: 60
            bottomLeftRadius: 60

            color: color1
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
            color: color1
            Text {
                anchors {
                    centerIn: parent
                }
                font.pixelSize: 60

                color: background
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
            color: color1
        }
    }
}
