import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Animations as ANIM
import qs.Modules.Bar.Widgets
import qs.Modules.Bar.Popups

PanelWindow {
    id: panel

    property int widthScreen: 1920

    property int mode
    property bool exclusiveMode
    property color color1
    property color color2
    property int widthStages
    property color background
    property color foreground

    property color backgroundBar: mode <= 1 ? "transparent" : background
    property color backgroundCapsule: mode == 0 ? background : "transparent"
    property int width_: mode == 1 ? widthScreen * (widthStages / 10) : widthScreen

    property bool hoverEnabled: false
    property bool centerHover: false
    property bool activeMenu: false

    exclusionMode: exclusiveMode ? ExclusionMode.Auto : ExclusionMode.Ignore

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

            Workspaces {
                color1: panel.color1
                foreground: panel.foreground
            }
            TrayButton {
                color1: panel.color1
            }
        }
    }

    // Center modules
    Rectangle {
        id: center

        implicitWidth: rowC.implicitWidth + 32
        implicitHeight: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        color: backgroundCapsule
        radius: 100

        // Main Menu
        PopupWindow {
            id: popupMain

            visible: centerHover || (menu.width > center.width)
            anchor.window: panel
            anchor.rect.x: parentWindow.width / 2 - width / 2
            anchor.rect.y: 0
            implicitWidth: 925
            implicitHeight: 375
            color: "transparent"

            property real lastWidth: popupMain.width
            property bool isDecreasing: false

            MainMenu {
                id: menu
                background: panel.background
                color1: centerHover ? panel.foreground : "transparent"

                width: centerHover ? parent.width : center.width
                height: centerHover ? parent.height : center.height
                x: centerHover ? 0 : popupMain.width / 2 - center.width / 2

                Behavior on width {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutCirc
                    }
                }
                Behavior on height {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutCirc
                    }
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutCirc
                    }
                }

                onWidthChanged: {
                    if (menu.width > lastWidth) {
                        isDecreasing = false;
                    } else if (menu.width < lastWidth) {
                        isDecreasing = true;
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: centerHover = !isDecresing
                onExited: centerHover = false
            }
        }

        RowLayout {
            id: rowC
            anchors.centerIn: parent
            spacing: 12

            Clock {
                color1: panel.color1
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: centerHover = true
            onExited: {
                hovered = false;
                hideTimer.restart();
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

            Sound {
                color1: panel.color1
                color2: panel.color2
            }
            Wifi {
                color1: panel.color1
            }
            Bluetooth {
                color1: panel.color1
            }
            Battery {
                color1: panel.color1
                color2: panel.color2
            }
            Power {
                color1: panel.color1
            }
        }
    }
}
