import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Services.UPower

Item {
    implicitWidth: battery.implicitWidth
    implicitHeight: battery.implicitHeight
    
    property color color1
    property color color2
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
        property bool pluggedIn: UPower.displayDevice.state === UPowerDeviceState.Unknown

        /*
            󱘖 
        */

        property string icon: {

            if ( UPower.displayDevice.state === UPowerDeviceState.Charging ) {
                return "";
            }
            else {
		        if ( pluggedIn ){
				    return "󱘖";
		        }
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
        text: hidePercentage || pluggedIn ? (icon) : (icon + " " + percent + "%")
        color: percent > 15 ? color1 : color2
    }
    
}
