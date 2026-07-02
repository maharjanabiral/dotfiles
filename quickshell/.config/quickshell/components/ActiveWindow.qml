import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire // unrelated, just showing import style
import Quickshell.Widgets

Rectangle {
    id: root

    readonly property var win: Hyprland.activeToplevel
    readonly property string appClass: win?.class ?? ""

    color: "#1e1e2e"
    opacity: 0.9
    radius: 14
    implicitWidth: row.implicitWidth + 24
    implicitHeight: 34
    border.color: "#313244"
    border.width: 1

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 10

        IconImage {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            implicitSize: 18
            // Quickshell resolves this against the system icon theme
            // using the window class -> desktop file -> Icon= entry
            source: Quickshell.iconPath(
                DesktopEntries.byId(root.appClass)?.icon ?? root.appClass,
                true // fallback to a generic icon if not found
            )
        }

        Text {
            id: title
            anchors.verticalCenter: parent.verticalCenter
            width: Math.min(implicitWidth, 260)
            elide: Text.ElideRight
            color: "#cdd6f4"
            font.pixelSize: 13
            text: root.win?.title ?? "Desktop"
        }
    }

    Behavior on implicitWidth {
        NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
    }
    Behavior on opacity {
        NumberAnimation { duration: 180 }
    }
}