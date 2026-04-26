import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Services.UPower

Item {
    implicitWidth: battery.implicitWidth
    implicitHeight: battery.implicitHeight
    
    Text {
        id: battery
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font"
        }

        property int percent: 100 * (UPower.displayDevice.percentage)

        property string icon: {
            switch (true) {
            case percent >= 90:
                return "󰁹";
                break;
            case percent >= 80:
                return "󰂂";
                break;
            case percent >= 70:
                return "󰂁";
                break;
            case percent >= 60:
                return "󰂀";
                break;
            case percent >= 50:
                return "󰁾";
                break;
            case percent >= 40:
                return "󰁽";
                break;
            case percent >= 30:
                return "󰁼";
                break;
            case percent >= 20:
                return "󰁻";
                break;
            default:
                return "󰁺";
                break;
            }
        }

        text: icon + " " + percent + "%"
        color: "#0db9d7"
    }
    
}
