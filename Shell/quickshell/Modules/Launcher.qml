import QtQuick
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell
import Quickshell.Io

PanelWindow {
    id: launcherWindow
    width: 400
    height: 500
    visible: false
    color: "transparent"
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    exclusionMode: ExclusionMode.Ignore

    // ipc launcher toggle
    IpcHandler {
        target: "launcher"

        function toggle(): void {
            console.log("Launcher is", launcherWindow.visible ? "not visible" : "visible");
            launcherWindow.visible = !launcherWindow.visible;
        }
    }
    Process {
        id: runLauncher

        command: ["bash", "-c", meuInput.text + "&"]
    }

    Rectangle {
        anchors.fill: parent
        color: "#292f3b"
        radius: 50
        TextField {
            id: meuInput
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: launcherWindow.width - 30
            height: launcherWindow.height / 10
            placeholderText: "Launcher is comming..."

            // Text color
            color: "white"

            // Text box
            background: Rectangle {
                color: "#3b4252"
                radius: 15
                border.color: meuInput.activeFocus ? "#88c0d0" : "#4c566a"
                border.width: 1
            }
            onAccepted: {
                console.log("Launcher: ENTER with '", meuInput.text, "'");
                launcherWindow.visible = false;
                runLauncher.running = true;
                meuInput.text = "";
            }
        }
    }
}
