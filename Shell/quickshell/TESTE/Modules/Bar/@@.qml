import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.Animations as ANIM
import "Widgets"

PanelWindow {
    id: root
    property int mode
    property color background

    property int menuWidth: 800
    property int menuHeight: 400
    
    

    implicitWidth: menuWidth
    implicitHeight: menuHeight
    color: "transparent"

    exclusiveZone: 0

    anchors.top: true
    margins.top: 10
    margins.right: 20


    Rectangle {
        id: content
        property bool expanded: hover.hovered

        implicitWidth: expanded ? menuWidth : rowC.implicitWidth + 32
        implicitHeight: expanded ? menuHeight : 50

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: mode == 0 ? background : "transparent"
        radius: expanded ? 20 : 100

        Behavior on implicitWidth {
            ANIM.Bezier{}
        }
        Behavior on implicitHeight {
            ANIM.Bezier{}
        }

        HoverHandler {
            id: hover
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
}
