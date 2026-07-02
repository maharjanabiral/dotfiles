
import QtQuick
import QtQuick.Layouts
import Quickshell
import "components"

ShellRoot {
    PanelWindow {
        implicitHeight: 40
        color: "transparent"
        margins { top: 10 }
        anchors { top: true; left: true; right: true }

        Workspaces {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 20
            }
        }

        // Center zone — clock and music share this space
        Item {
            id: centerZone
            anchors.centerIn: parent
            width: BarState.showMusic ? musicWidget.implicitWidth : clockText.implicitWidth + 30
            height: 40

            Behavior on width {
                NumberAnimation { duration: 350; easing.type: Easing.InOutCubic }
            }

            // Morphing pill background
            Rectangle {
                anchors.fill: parent
                radius: 20
                color: BarState.showMusic ? "#1a1a2e" : "transparent"
                border.color: BarState.showMusic ? "#33cdd6f4" : "transparent"
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }
            }

            // Clock — fades out when music is shown
            Clock {
                id: clockText
                anchors.centerIn: parent
                opacity: BarState.showMusic ? 0 : 1
                scale:   BarState.showMusic ? 0.85 : 1
                Behavior on opacity { NumberAnimation { duration: 200 } }
                Behavior on scale   { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
            }

            // Music player — fades in when shown
            Music {
                id: musicWidget
                anchors.centerIn: parent
                opacity: BarState.showMusic ? 1 : 0
                scale:   BarState.showMusic ? 1 : 0.92
                Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.InOutCubic } }
                Behavior on scale   { NumberAnimation { duration: 250; easing.type: Easing.InOutCubic } }
            }

            // Scroll handler on the whole center zone
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                onWheel: event => {
                    if (!BarState.isPlaying) return
                    BarState.showMusic = event.angleDelta.y < 0
                }
            }
        }

        // Right-side cluster: NotificationCenter + Audio
        RowLayout {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 20
            }
            spacing: 8

            NotificationCenter {}

            Audio {}
            PowerButton {}
        }
    }
}
