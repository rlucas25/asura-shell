import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

PanelWindow {

    visible: osdVisible
    margins.top: 45
    margins.left: 8

    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore

    anchors.top: true
    anchors.left: true

    implicitWidth: 140
    implicitHeight: 200

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 40
        color: "#383443"

        RowLayout {

            spacing: 8
            anchors.margins: 8

            Repeater {
                model: SystemTray.items

                delegate: Item {
                    implicitWidth: 20
                    implicitHeight: 20

                    Image {
                        anchors.centerIn: parent
                        width: 16
                        height: 16
                        source: modelData.icon
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            modelData.activate();
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        spacing: 8
        implicitHeight: 32
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "Tray"
            color: "#0db9d7"
        }
    }
}
