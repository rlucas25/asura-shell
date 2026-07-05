import QtQuick

Item {
    id: root

    property string icon
    property string detail: ""
    property color textColor: "#0db9d7"
    property string indicatorId: ""
    property QtObject hoverState: null
    property bool pinned: false

    implicitWidth: 20
    implicitHeight: 20
    width: implicitWidth
    height: implicitHeight

    signal clicked()

    function tooltipText() {
        if (detail.length > 0)
            return icon + " " + detail
        return icon
    }

    function activate() {
        if (!hoverState)
            return
        hoverState.active = indicatorId
        hoverState.tooltip = tooltipText()
    }

    function deactivate() {
        if (!hoverState)
            return
        if (hoverState.active === indicatorId)
            hoverState.active = ""
        if (hoverState.pinnedTooltip !== "") {
            hoverState.active = hoverState.pinnedTooltip
            hoverState.tooltip = hoverState.pinnedText
        } else {
            hoverState.tooltip = ""
        }
    }

    Text {
        anchors.centerIn: parent
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }
        text: root.icon
        color: root.textColor
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            root.hovered = true
            root.activate()
        }

        onExited: {
            root.hovered = false
            if (!pinned)
                root.deactivate()
        }

        onClicked: root.clicked()
    }

    property bool hovered: false

    onPinnedChanged: {
        if (!hoverState)
            return
        if (pinned) {
            hoverState.pinnedTooltip = indicatorId
            hoverState.pinnedText = tooltipText()
            hoverState.active = indicatorId
            hoverState.tooltip = tooltipText()
        } else if (hoverState.pinnedTooltip === indicatorId) {
            hoverState.pinnedTooltip = ""
            hoverState.pinnedText = ""
            if (!hovered)
                deactivate()
        }
    }
}
