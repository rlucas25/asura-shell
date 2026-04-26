import Quickshell
import Quickshell.Wayland
import QtQuick

import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {

    Repeater {
        model: 3
        Rectangle {
            property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
            
            
            radius: 100
            Layout.preferredHeight: 15
            Layout.preferredWidth: isActive ? 35 : 15

            color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
            
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
