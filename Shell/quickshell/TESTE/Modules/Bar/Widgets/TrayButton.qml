import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
    anchors.margins: 8
    spacing: 8

    
    property color color1
    property bool hoverEnabled: false
    property bool openTray: false
    property bool hovered: false

    Timer {
        id: hideTimer

        interval: 500
        repeat: false

        onTriggered: {
            if (!hovered)
                openTray = false;
        }
    }

    Canvas {
        width: 14
        height: 7
        onPaint: {
            var ctx = getContext("2d");

            ctx.clearRect(0, 0, width, height);

            ctx.beginPath();
            ctx.moveTo(width / 2, height);      // ponto de cima
            ctx.lineTo(width, 0);     // ponto inferior direito
            ctx.lineTo(0, 0);         // ponto inferior esquerdo
            ctx.closePath();

            ctx.fillStyle = color1;
            ctx.fill();
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: openTray = true
        onExited: {
            hovered: false
            hideTimer.restart()
        }
    }

    RowLayout {
        anchors.fill: parent
        visible: openTray

        spacing: 12
        anchors.leftMargin: 22

        Repeater {
            model: SystemTray.items

            delegate: Item {
                implicitWidth: 14
                implicitHeight: 14

                Image {
                    width: 14
                    height: 14
                    source: modelData.icon
                }
            }
        }
    }
}
