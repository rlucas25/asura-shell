import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "Components"

PanelWindow {
    property color backgroundColor: "#383443"

    property bool hoverEnabled: false
    property bool centerHover: false

    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: 8
    margins.left: 8
    margins.right: 8

    implicitHeight: 30
    //color: '#c71e1b26'
    color: 'transparent'

    // Left modules
    Rectangle {
        id: left
        implicitWidth: rowL.implicitWidth + 32
        implicitHeight: parent.height
        radius: 100
        color: backgroundColor

        RowLayout {
            id: rowL
            anchors.centerIn: parent
            spacing: 8

            Workspaces {}
            TrayButton {}
        }
    }

    // Center modules
    Rectangle {
        id: center

        implicitWidth: rowC.implicitWidth + 32
        implicitHeight: parent.height
        anchors.centerIn: parent
        radius: 100
        color: backgroundColor

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: centerHover = true

            onClicked: {
                activeMenu = !activeMenu;
            }
        }
        MainMenu {
            visible: centerHover
            onCloseRequested: {
                centerHover = false;
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onExited: centerHover = false
            }
        }

        RowLayout {
            id: rowC
            anchors.centerIn: parent
            spacing: 8
            Clock {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }

    //Right modules
    Rectangle {
        id: right
        implicitWidth: rowR.implicitWidth + 32
        implicitHeight: parent.height
        anchors.right: parent.right
        radius: 100
        color: backgroundColor

        RowLayout {
            id: rowR
            anchors.centerIn: parent
            spacing: 8

            Wifi {}
            Battery {}

            Rectangle {
                Layout.preferredWidth: 15
                Layout.preferredHeight: 15

                color: "#0db9d7"
                radius: 100
            }
        }
    }
}
