import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Services.UPower

Item {
    implicitWidth: battery.implicitWidth
    implicitHeight: battery.implicitHeight
    
        
    property bool hoverEnabled: false
    property bool hidePercentage: false
    
    MouseArea {
        anchors.fill: parent
        onClicked: hidePercentage = !hidePercentage
    }

    Text {
        id: battery
        font {
            pixelSize: 14
            family: "JetBrainsMono Nerd Font Propo"
        }

        property int percent: 100 * (UPower.displayDevice.percentage)
        /*
            󱘖 
        */

        property string icon: {

            if ( UPower.displayDevice.state === UPowerDeviceState.Charging ) {
                return "";
            }

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

        //text: icon + " " + percent + "%" + stats
        text: hidePercentage ? (icon) : (icon + " " + percent + "%")
        color: "#0db9d7"
    }
    
}
