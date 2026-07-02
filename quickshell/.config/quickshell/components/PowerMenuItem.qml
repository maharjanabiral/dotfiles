// components/PowerMenuItem.qml
import QtQuick
import QtQuick.Layouts
import "../themes"

Rectangle {
    id: item
    property string label: ""
    property string icon: ""
    property bool danger: false
    signal clicked()

    Layout.fillWidth: true
    implicitHeight: 32
    radius: 8
    color: itemMouse.containsMouse
        ? (danger ? "#33f38ba8" : "#33313244")
        : "transparent"

    Behavior on color { ColorAnimation { duration: 120 } }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 8

        Text {
            text: item.icon
            font.pixelSize: 13
            color: item.danger ? Colors.error : Colors.primary
        }
        Text {
            text: item.label
            font.pixelSize: 13
            font.family: "SF Mono"
            color: item.danger ? Colors.error : Colors.primary
            Layout.fillWidth: true
        }
    }

    MouseArea {
        id: itemMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: item.clicked()
    }
}