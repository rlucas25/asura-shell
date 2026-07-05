pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property alias cfg: adapter
    property bool ready: false

    FileView {
        id: file
        path: Quickshell.shellRoot + "/config.json"
        watchChanges: true

        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        onLoaded: root.ready = true
        onLoadFailed: (error) => {
            if (error === FileViewError.FileNotFound)
                writeAdapter()
            else
                reload()
        }
    
        JsonAdapter {
            id: adapter

            property real opacity: 1.0
            property real widthS: 7
            property int barMode: 2
            property bool exclusiveMode: true
            property string backgroundColor: '#302c39'
            property string foregroundColor: "#444b6a"
            property string color1: "#0db9d7"
            property string color2: "#ed7e4e"
        }
    }
}
