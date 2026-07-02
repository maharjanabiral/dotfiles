import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../themes"
Item {
    id: root

    property int notifCount: 0
    property bool doNotDisturb: false
    property bool isHovered: false
    property bool isPressed: false
    readonly property color accentColor: doNotDisturb ? "#f38ba8" : notifCount > 0 ? "#cdd6f4" : "#6c7086"
    readonly property color pillColor: isPressed ? "#2a2a3e" : isHovered ? "#1e1e30" : Colors.background

    implicitWidth: pill.width
    implicitHeight: 40

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            countProc.running = true;
            dndProc.running = true;
        }
    }

    Process {
        id: countProc

        command: ["swaync-client", "--count"]

        stdout: SplitParser {
            onRead: (data) => {
                const n = parseInt(data.trim());
                if (!isNaN(n))
                    root.notifCount = n;

            }
        }

    }

    Process {
        id: dndProc

        command: ["swaync-client", "--get-dnd"]

        stdout: SplitParser {
            onRead: (data) => {
                root.doNotDisturb = data.trim() === "true";
            }
        }

    }

    Process {
        id: toggleProc

        command: ["swaync-client", "--toggle-panel"]
    }

    Rectangle {
        id: pill

        width: row.implicitWidth + 40
        height: 35
        radius: 20
        color: Colors.surface
        border.color: Colors.primary
        border.width: 1
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: root.notifCount > 0 && !root.doNotDisturb ? "#22cdd6f4" : "transparent"
            border.width: 6

            Behavior on border.color {
                ColorAnimation {
                    duration: 300
                }

            }

        }

        RowLayout {
            id: row

            anchors.centerIn: parent
            spacing: 5

            Text {
                text: root.doNotDisturb ? "\uf1f6" : "\uf0f3" // nf-fa-bell_slash / nf-fa-bell
                color: root.accentColor
                font.pixelSize: 16 // change this to any size
                font.family: "JetBrainsMono Nerd Font" // or whichever nerd font you have
                Layout.alignment: Qt.AlignVCenter

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }

                }

            }

            Text {
                id: countLabel

                text: root.notifCount > 99 ? "99+" : root.notifCount.toString()
                color: root.accentColor
                font.pixelSize: 20
                font.family: "monospace"
                font.weight: Font.Medium
                visible: root.notifCount > 0
                opacity: root.notifCount > 0 ? 1 : 0
                Layout.alignment: Qt.AlignVCenter

                Behavior on opacity {
                    NumberAnimation {
                        duration: 180
                    }

                }

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }

                }

            }

        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: root.isHovered = true
            onExited: {
                root.isHovered = false;
                root.isPressed = false;
            }
            onPressed: root.isPressed = true
            onReleased: root.isPressed = false
            onClicked: toggleProc.running = true
        }

        Behavior on width {
            NumberAnimation {
                duration: 220
                easing.type: Easing.InOutCubic
            }

        }

        Behavior on color {
            ColorAnimation {
                duration: 150
            }

        }

        Behavior on border.color {
            ColorAnimation {
                duration: 150
            }

        }

        transform: Scale {
            origin.x: pill.width / 2
            origin.y: pill.height / 2
            xScale: root.isPressed ? 0.92 : 1
            yScale: root.isPressed ? 0.92 : 1

            Behavior on xScale {
                NumberAnimation {
                    duration: 100
                }

            }

            Behavior on yScale {
                NumberAnimation {
                    duration: 100
                }

            }

        }

    }

}
