import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Canvas {
    width: 14
    height: 7

    property bool hoverEnabled: false
    property bool openTray: false

    onPaint: {
        var ctx = getContext("2d");

        ctx.clearRect(0, 0, width, height);

        ctx.beginPath();
        ctx.moveTo(width / 2, height);      // ponto de cima
        ctx.lineTo(width, 0);     // ponto inferior direito
        ctx.lineTo(0, 0);         // ponto inferior esquerdo
        ctx.closePath();

        ctx.fillStyle = "#0db9d7";
        ctx.fill();
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: openTray = true
    }

    TrayMenu {
        visible: openTray

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: openTray = true
            onExited: openTray = false
        }
    }
}
