//@ pragma UseQApplication

import Quickshell
import QtQuick
import Quickshell.Wayland
import "./modules/Bar/"

ShellRoot {
    id: root

    Loader {
        active: true
        //sourceComponent: OSDs{}
        sourceComponent: Bar{}
    }
}
