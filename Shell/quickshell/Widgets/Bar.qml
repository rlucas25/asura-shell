import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../Components"

PanelWindow {
    id: panel

    property int widthScreen: 1920

    property int mode
    property color bgColor
    property color color1
    property color color2
    property int widthStages;    
    property color background;

    property color backgroundBar: mode <= 1 ? "transparent" : background 
    property color backgroundCapsule: mode == 0 ? background : "transparent"
    property int width_: mode == 1 ? widthScreen*(widthStages/10) : widthScreen;

    property bool hoverEnabled: false
    property bool centerHover: false
    property bool activeMenu: false

    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        top: mode <= 1 ? 6 : 0
        left: mode <= 1 ? 6 : 0
        right: mode <= 1 ? 6 : 0
    }

    implicitHeight: 30
    color: backgroundBar

    Rectangle {
        id: backgroundbar
        visible: (mode == 1)
        implicitWidth: width_
        implicitHeight: panel.height
        radius: 100
        anchors.centerIn: parent
        color: background
    }

    // Left modules
    Rectangle {
        id: left
        implicitWidth: rowL.implicitWidth + 32 + widthScreen - width_
        implicitHeight: panel.height
        radius: 100
        color: backgroundCapsule

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
        
        property bool expanded: hover.hovered

        implicitWidth: expanded ? 340 : rowC.implicitWidth + 32
        implicitHeight: expanded ? 120 : panel.height

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: backgroundCapsule
        radius: 100
    
        Behavior on implicitWidth { NumberAnimation { duration: 500; easing.type: Easing.Bezier; easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1] } }
        Behavior on implicitHeight { NumberAnimation { duration: 500; easing.type: Easing.Bezier; easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1] } }
    
        HoverHandler { id: hover}

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
        implicitWidth: rowR.implicitWidth + 32 + (widthScreen - width_)
        implicitHeight: parent.height
        anchors.right: parent.right
        radius: 100
        color: backgroundCapsule

        RowLayout {
            id: rowR
            anchors.centerIn: parent
            spacing: 12

            Sound {}
            Wifi {}
            Bluetooth {}
            Battery {
                color1: panel.color1
                color2: panel.color2
            }
            Power {}

        }
    }
}
