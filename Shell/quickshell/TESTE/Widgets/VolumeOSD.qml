import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.Animations as ANIM

Scope {
    id: root

    property bool verticalMode
    property color background
    property color color1
    property color color2

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: shouldShowOsd

        PanelWindow {
            id: panelWindow
            implicitWidth: verticalMode ? 50 : 300
            implicitHeight: verticalMode ? 300 : 50
            color: "transparent"

            exclusiveZone: 0

            anchors.right: verticalMode
            anchors.bottom: !verticalMode

            margins.right: verticalMode ? implicitWidth : undefined
            margins.bottom: verticalMode ? undefined : implicitHeight

            property bool muted: {
                if (!Pipewire.defaultAudioSink || Pipewire.defaultAudioSink.audio.muted)
                    return true;
                return false;
            }
            property int volumeLevel: Pipewire.defaultAudioSink ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) : 0
            property string icon: {
                if (muted || volumeLevel === 0)
                    return "";

                if (volumeLevel >= 60)
                    return "";

                return "";
            }

            Rectangle {
                id: content
                implicitHeight: parent.height
                
                color: background
                clip: true

                states: [
                    State {
                        name: "show"
                        PropertyChanges {
                            target: content
                            width: parent.width
                            opacity: 1.0
                            radius: 20
                        }
                    }
                ]

                state: ""
                width: 0.0
                opacity: 0.0
                radius: 100
                
                Component.onCompleted: content.state = "show"

                transitions: [
                    Transition {
                        from: ""; to: "show"
                        NumberAnimation {
                            properties: "width,opacity,radius"
                            duration: 100
                            easing.type: Easing.OutCirc
                        }
                    }
                ]
                

                Rectangle {
                    implicitWidth: verticalMode ? parent.width : parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                    implicitHeight: verticalMode ? parent.height * (Pipewire.defaultAudioSink?.audio.volume ?? 0) : parent.height
                    radius: parent.radius
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    color: color1
                    clip: true

                    Behavior on implicitHeight {
                        ANIM.Bezier {}
                    }
                    Behavior on implicitWidth {
                        ANIM.Bezier {}
                    }
                }
                Text {

                    anchors.bottom: verticalMode ? parent.bottom : undefined
                    anchors.horizontalCenter: verticalMode ? parent.horizontalCenter : undefined

                    anchors.left: verticalMode ? undefined : parent.left
                    anchors.verticalCenter: verticalMode ? undefined : parent.verticalCenter

                    anchors.margins: 20
                    text: icon
                    color: muted ? color2 : background
                }
            }
        }
    }
}
