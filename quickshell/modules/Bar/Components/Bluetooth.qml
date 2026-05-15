import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Bluetooth

Item {
    implicitWidth: bluetooth.implicitWidth
    implicitHeight: bluetooth.implicitHeight

    property int state: 0

    property var adapter: Bluetooth.adapters.values[0]

    property string icon: {
        if (!adapter)
            return "󰂲";

        if (adapter.state === BluetoothAdapterState.Disabled || adapter.state === BluetoothAdapterState.Blocked) {
            return "󰂲";
        }

        return "󰂯";
    }

    Text {
        id: bluetooth
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }

        // ""
        text: icon
        color: "#0db9d7"
    }
}
