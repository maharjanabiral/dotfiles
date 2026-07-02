// import QtQuick
// import Quickshell
// import Quickshell.Services.Mpris
// import "../themes"

// Rectangle {
//     property bool showVolume: BarState.showVolume
//     property var activePlayer: Mpris.players.values.find(p => p.playbackState === MprisPlaybackState.Playing) ?? null
//     property bool showMusic: !showVolume && activePlayer !== null

//     implicitWidth: showVolume ? 300 : (showMusic ? 180 : label.implicitWidth + 100)
//     implicitHeight: 40
//     radius: 20
//     color: Colors.surface
//     border.color: Colors.primary
//     border.width: 1

//     HoverHandler { id: clockHover }

//     // Clock text
//     Text {
//         id: label
//         anchors.centerIn: parent
//         text: Qt.formatDateTime(clock.date, "hh:mm")
//         color: Colors.primary
//         // opacity: (showVolume || showMusic) ? 0 : 1
//         opacity: showVolume ? 0 : 1
//         font {
//             family: "SF Mono"
//             pixelSize: 16
//             weight: 600
//         }
//         Behavior on opacity {
//             NumberAnimation { duration: 150 }
//         }
//     }

//     // Volume bar
//     Item {
//         anchors.fill: parent
//         anchors.margins: 12
//         opacity: showVolume ? 1 : 0
//         visible: opacity > 0

//         Text {
//             id: volIcon
//             text: BarState.volume == 0 ? String.fromCodePoint(984449) : BarState.volume < 34 ? String.fromCodePoint(984447) : String.fromCodePoint(984446)
//             color: Colors.primary
//             anchors {
//                 left: parent.left
//                 verticalCenter: parent.verticalCenter
//             }
//             font {
//                 family: "JetBrainsMono Nerd Font"
//                 pixelSize: 16
//             }
//         }
//         Rectangle {
//             id: trackBg
//             height: 4
//             radius: 2
//             color: Colors.primary
//             anchors {
//                 left: volIcon.right
//                 right: parent.right
//                 verticalCenter: parent.verticalCenter
//                 leftMargin: 8
//             }
//             Rectangle {
//                 width: parent.width * (BarState.volume / 100)
//                 height: parent.height
//                 radius: parent.radius
//                 color: Colors.primary
//                 Behavior on width {
//                     NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
//                 }
//             }
//         }
//         Behavior on opacity {
//             NumberAnimation { duration: 150 }
//         }
//     }

//     // // Music visualizer — only when a player is actively playing
//     // Item {
//     //     anchors.fill: parent
//     //     anchors.margins: 12
//     //     opacity: showMusic ? 1 : 0
//     //     visible: opacity > 0

//     //     CavaBars {
//     //         id: cavaBars
//     //         anchors.centerIn: parent
//     //         barCount: 12
//     //         height: 20
//     //     }
//     //     Behavior on opacity {
//     //         NumberAnimation { duration: 150 }
//     //     }
//     // }

//     SystemClock {
//         id: clock
//         precision: SystemClock.Minutes
//     }

//     Behavior on implicitWidth {
//         NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
//     }
//     Behavior on implicitHeight {
//         NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
//     }

//     HoverHandler {
//         id: hover
//         onHoveredChanged: BarState.showCalendar = hovered
//     }
// }

import QtQuick
import Quickshell
import "../themes"

Rectangle {
    property bool showVolume: BarState.showVolume

    implicitWidth: showVolume
        ? 300
        : label.implicitWidth + 100

    implicitHeight: 40
    radius: 20

    color: Colors.surface
    border.color: Colors.primary
    border.width: 1

    HoverHandler {
        id: clockHover
    }

    // Clock text
    Text {
        id: label

        anchors.centerIn: parent

        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: Colors.primary
        opacity: showVolume ? 0 : 1

        font {
            family: "SF Mono"
            pixelSize: 16
            weight: 600
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    // Volume bar
    Item {
        anchors.fill: parent
        anchors.margins: 12

        opacity: showVolume ? 1 : 0

        Text {
            id: volIcon

            text: BarState.volume == 0
                ? String.fromCodePoint(984449)
                : BarState.volume < 34
                    ? String.fromCodePoint(984447)
                    : String.fromCodePoint(984446)

            color: Colors.primary

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 16
            }
        }

        Rectangle {
            id: trackBg

            height: 4
            radius: 2
            color: Colors.primary

            anchors {
                left: volIcon.right
                right: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: 8
            }

            Rectangle {
                width: parent.width * (BarState.volume / 100)
                height: parent.height

                radius: parent.radius
                color: Colors.primary

                Behavior on width {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    HoverHandler {
        id: hover

        onHoveredChanged: {
            BarState.showCalendar = hovered
        }
    }
}