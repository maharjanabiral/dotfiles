import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../themes"

Rectangle {
    implicitWidth: row.implicitWidth + 24
    implicitHeight: 35
    radius: 20
    color: Colors.surface
    border.color: Colors.primary
    border.width: 1

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property var sink: Pipewire.defaultAudioSink
    readonly property bool ready: Pipewire.ready && sink !== null && sink.audio !== null
    readonly property real volume: ready ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: ready && sink.audio.muted

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: BarState.showVolume = false
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: muted ? String.fromCodePoint(0xf0481) :
                  volume == 0 ? String.fromCodePoint(0xf0581) :
                  volume < 34 ? String.fromCodePoint(0xf057f) :String.fromCodePoint(0xf057e)
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 18
            }
            color: Colors.primary

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (sink?.audio) sink.audio.muted = !sink.audio.muted
                }
                onWheel: (event) => {
                    if (sink?.audio) {
                        const delta = event.angleDelta.y > 0 ? 0.05 : -0.05
                        sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + delta))
                        BarState.volume = volume
                        BarState.showVolume = true
                        hideTimer.restart()
                    }
                }
            }
        }

        Text {
            text: volume + "%"
            font {
                family: "SF Mono"
                pixelSize: 14
            }
            color: Colors.primary
        }
    }
}
