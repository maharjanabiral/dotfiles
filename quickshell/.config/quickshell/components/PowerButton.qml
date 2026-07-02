// components/PowerButton.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../themes"

Item {
    id: root
    implicitWidth: 35
    implicitHeight: 35

    property bool menuOpen: false

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: mouseArea.containsMouse || root.menuOpen ? Colors.outline : Colors.surface
        border.color: Colors.primary 
        border.width: 1

        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            text: String.fromCodePoint(0xf011)
            font.pixelSize: 16
            color: Colors.error
            anchors.verticalCenterOffset: -2
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.menuOpen = !root.menuOpen
    }

    // Popup menu
    PopupWindow {
        id: popup
        visible: root.menuOpen
        anchor.item: root
        anchor.rect.x: root.width / 2 - implicitWidth / 2
        anchor.rect.y: root.height + 10
        implicitWidth: 160
        implicitHeight: menuColumn.implicitHeight + 16
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 14
            color: Colors.surface
            border.color: Colors.primary
            border.width: 1

            ColumnLayout {
                id: menuColumn
                anchors.fill: parent
                anchors.margins: 8
                spacing: 4

                PowerMenuItem {
                    label: "Lock"
                    icon: String.fromCodePoint(0xf023)
                    onClicked: {
                        root.menuOpen = false
                        lockProc.running = true
                    }
                }
                PowerMenuItem {
                    label: "Restart"
                    icon: String.fromCodePoint(0xf0709)
                    onClicked: {
                        root.menuOpen = false
                        restartProc.running = true
                    }
                }
                PowerMenuItem {
                    label: "Shutdown"
                    icon: String.fromCodePoint(0xf011)
                    danger: true
                    onClicked: {
                        root.menuOpen = false
                        shutdownProc.running = true
                    }
                }
            }
        }
    }

    // Click-outside-to-close catcher
    MouseArea {
        anchors.fill: undefined
        visible: false
    }

    Process {
        id: lockProc
        command: ["loginctl", "lock-session"]
    }
    Process {
        id: restartProc
        command: ["systemctl", "reboot"]
    }
    Process {
        id: shutdownProc
        command: ["systemctl", "poweroff"]
    }
}