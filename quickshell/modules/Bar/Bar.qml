import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "Components"

PanelWindow {



    // === CONFIG ===

    property bool soliMode: false
    
    property color solidColor: "#383443"

    property color backgroundColor1: soliMode ? solidColor : 'transparent'
    property color backgroundColor:  "#383443"

    // ========

    property bool hoverEnabled: false
    property bool centerHover: false

    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: soliMode ? 0 : 6
    margins.left: soliMode ? 0 : 6
    margins.right: soliMode ? 0 : 6

    implicitHeight: 30
    //color: "#383443"
    color: backgroundColor1

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
            spacing: 12

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
            spacing: 12
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
            spacing: 12


            Sound {}
            
            Wifi {}

            Bluetooth {}
            
            Battery {}
            
            Power {}
        }
    }
}
