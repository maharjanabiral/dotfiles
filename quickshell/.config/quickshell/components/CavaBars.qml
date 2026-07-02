import QtQuick
import Quickshell
import Quickshell.Io
import "../themes"

Item {
    id: root
    property int barCount: 8
    property var levels: Array(barCount).fill(0)

    implicitWidth: barsRow.implicitWidth
    implicitHeight: parent ? parent.height : 20

    Process {
        id: cavaProc
        running: root.visible
        command: ["cat", "/tmp/cava_quickshell.fifo"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (!data || data.length === 0) return
                const parts = data.split(";").filter(s => s.length > 0)
                if (parts.length === 0) return
                root.levels = parts.map(p => parseInt(p, 10) || 0)
            }
        }
    }

    Row {
        id: barsRow
        anchors.verticalCenter: parent.verticalCenter
        spacing: 3
        height: 20

        Repeater {
            model: root.barCount
            Rectangle {
                width: 3
                radius: 1.5
                color: Colors.primary
                height: Math.max(3, (root.levels[index] ?? 0) / 7 * 20)
                anchors.bottom: parent.bottom

                Behavior on height {
                    NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                }
            }
        }
    }
}