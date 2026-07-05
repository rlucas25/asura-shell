import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Bluetooth

Item {
    
    property color color1
    

    implicitWidth: bluetooth.implicitWidth
    implicitHeight: bluetooth.implicitHeight

    property bool hoverEnabled: false
    property bool hovered: false
    property bool opened: false

    property int state: 0

    property var adapter: Bluetooth.adapters.values[0]

    property string icon: {
        if (Bluetooth.devices.values[1].state === BluetoothDeviceState.Connected) {
            if (Bluetooth.devices.values[1].icon === "audio-headset")
                return "";
            return "󰂱";
        }
        if (adapter.state === BluetoothAdapterState.Enabled) {
            return "󰂯";
        }
        if (adapter.state === BluetoothAdapterState.Disabled || adapter.state === BluetoothAdapterState.Blocked) {
            return "󰂲";
        }
    }

    Timer {
        id: hideTimer

        interval: 500
        repeat: false

        onTriggered: {
            if (!hovered)
                opened = false;
        }
    }

    Text {
        id: bluetooth
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }

        text: opened ? icon + " " + (Bluetooth.devices.values[1].battery) * 100 + "%" : icon
        color: color1
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: opened = true
        onExited: {
            hovered = false;
            hideTimer.restart();
        }
    }
}
