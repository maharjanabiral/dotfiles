// import Quickshell
// import Quickshell.Hyprland
// import QtQuick
// import QtQuick.Layouts
// import "../themes"

// Item {
//     id: root
//     implicitWidth: rowLayout.implicitWidth + 32
//     implicitHeight: 30

//     Rectangle {
//         anchors.fill: parent
//         radius: height / 2
//         color: Colors.surface ?? "#1a1a2e"
//         border.color: Colors.primary
//     }

//     RowLayout {
//         id: rowLayout
//         anchors.centerIn: parent
//         spacing: 18

//         Repeater {
//             model: 6
//             Item {
//                 id: wsButton
//                 required property int index
//                 property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
//                 property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
//                 property bool isOccupied: ws !== undefined

//                 implicitHeight: 16
//                 implicitWidth: isActive ? 18 : 6

//                 Behavior on implicitWidth {
//                     NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
//                 }

//                 Rectangle {
//                     anchors.centerIn: parent
//                     width: parent.implicitWidth
//                     height: 6
//                     radius: 3
//                     color: wsButton.isActive
//                         ? Colors.primary
//                         : Colors.text ?? "#cdd6f4"
//                     opacity: wsButton.isActive
//                         ? 1
//                         : (wsButton.isOccupied ? 0.6 : 0.3)

//                     Behavior on color   { ColorAnimation { duration: 180 } }
//                     Behavior on opacity { NumberAnimation { duration: 180 } }
//                 }

//                 MouseArea {
//                     anchors.fill: parent
//                     // widen hit area a bit since dots are small
//                     anchors.margins: -4
//                     cursorShape: Qt.PointingHandCursor
//                     onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (wsButton.index + 1) + "})")
//                 }
//             }
//         }
//     }
// }

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../themes"

RowLayout {
    spacing: 20

    Repeater {
        model: 5

        Item {
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            property bool isOccupied: ws !== undefined

            implicitHeight: 14
            implicitWidth: isActive ? 30 : 15

            Behavior on implicitWidth {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            Rectangle {
                x: (parent.implicitWidth - width) / 2
                y: (parent.implicitHeight - height) / 2

                width: parent.implicitWidth
                height: wsButton.isActive ? 6 : 4
                radius: height / 2

                color: wsButton.isActive
                    ? Colors.primary
                    : (wsButton.isOccupied ? Colors.secondary : Colors.outline)

                Behavior on color {
                    ColorAnimation { duration: 180 }
                }

                Behavior on height {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (wsButton.index + 1) + "})")
            }
        }
    }
}
