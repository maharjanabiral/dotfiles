import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Item {
    id: root
    implicitWidth: row.implicitWidth + 60
    implicitHeight: 40

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 12

        // Prev
        Text {
            text: "⏮"
            color: "#f5e2c5"
            font.pixelSize: 12
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: BarState.player?.previous()
            }
        }

        // Play / Pause button
        Rectangle {
            width: 22; height: 22; radius: 11
            color: "#f5e2c5"
            Text {
                anchors.centerIn: parent
                text: BarState.isPlaying ? "⏸" : "▶"
                color: "#00000e"
                font.pixelSize: 10
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: BarState.player?.togglePlaying()
            }
        }

        // Next
        Text {
            text: "⏭"
            color: "#f5e2c5"
            font.pixelSize: 12
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: BarState.player?.next()
            }
        }

        // Divider
        Rectangle { width: 1; height: 14; color: "#313244" }

        // Track info + seek bar stacked
        ColumnLayout {
            spacing: 3
            Layout.maximumWidth: 300

            // Artist — Title
            Text {
                Layout.maximumWidth: 220
                text: {
                    const a = BarState.player?.trackArtists?.join(", ") ?? ""
                    const t = BarState.player?.trackTitle ?? ""
                    if (a && t) return a + "  ·  " + t
                    return t || a || "Nothing playing"
                }
                color: "#f5e2c5"
                font.pixelSize: 11
                font.weight: Font.Medium
                elide: Text.ElideRight
            }

            // Seek bar
            Item {
                Layout.fillWidth: true
                implicitWidth: 220
                height: 3

                Rectangle {
                    anchors.fill: parent
                    radius: 2
                    color: "#313244"
                }

                Rectangle {
                    width: {
                        const d = BarState.player?.trackDuration ?? 0
                        const p = BarState.player?.position ?? 0
                        return d > 0 ? parent.width * (p / d) : 0
                    }
                    height: 3; radius: 2
                    color: "#89b4fa"
                    Behavior on width { NumberAnimation { duration: 800; easing.type: Easing.Linear } }
                }

                MouseArea {
                    anchors { fill: parent; margins: -4 }
                    cursorShape: Qt.PointingHandCursor
                    onClicked: mouse => {
                        const d = BarState.player?.trackDuration ?? 0
                        if (d > 0) BarState.player.position = (mouse.x / width) * d
                    }
                }
            }
        }
    }
}
