import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../Bar/Widgets"

PanelWindow {
    visible: osdVisible
    margins.top: 8 

    signal closeRequested

    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore

    anchors.top: true

    implicitWidth: 700
    implicitHeight: 400

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 60
        color: "#383443"
    }

    RowLayout {
        spacing: 8
        implicitHeight: 32
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        
        Clock {}

        MouseArea {
            anchors.fill: parent

            onClicked: closeRequested()
        }
    }
}
