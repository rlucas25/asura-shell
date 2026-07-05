import Quickshell
import Quickshell.Wayland
import QtQuick

import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: root
    property color color1

    property color foreground

    property int numNodes: 3

    Repeater {
        model: numNodes
        Rectangle {
            property int aux: numNodes * Math.floor(((Hyprland.focusedWorkspace?.id) - 1) / numNodes)

            property var ws: Hyprland.workspaces.values.find(w => w.id == (index + 1 + aux))
            property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1 + aux)

            radius: 100
            Layout.preferredHeight: 15
            Layout.preferredWidth: isActive ? 30 : 15

            color: isActive ? color1 : (ws ? Qt.alpha(color1, 0.5) : foreground)

            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCirc
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }
}
