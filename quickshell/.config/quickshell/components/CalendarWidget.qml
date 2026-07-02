import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    width: 320
    height: 340

    radius: 18
    color: "#1a1a2e"
    border.color: "#2d2d44"
    border.width: 1

    property date currentDate: new Date()

    Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Row {
            width: parent.width
            spacing: 10

            Button {
                text: "<"
                onClicked: {
                    root.currentDate =
                        new Date(root.currentDate.getFullYear(),
                                 root.currentDate.getMonth() - 1,
                                 1)
                }
            }

            Text {
                width: parent.width - 80
                horizontalAlignment: Text.AlignHCenter

                text: Qt.locale().standaloneMonthName(
                          root.currentDate.getMonth() + 1
                      ) + " " + root.currentDate.getFullYear()

                color: "white"

                font.pixelSize: 18
                font.bold: true
            }

            Button {
                text: ">"
                onClicked: {
                    root.currentDate =
                        new Date(root.currentDate.getFullYear(),
                                 root.currentDate.getMonth() + 1,
                                 1)
                }
            }
        }

        DayOfWeekRow {
            locale: Qt.locale()
        }

        MonthGrid {
            id: grid

            month: root.currentDate.getMonth()
            year: root.currentDate.getFullYear()

            locale: Qt.locale()

            anchors.horizontalCenter: parent.horizontalCenter

            delegate: Rectangle {
                required property var model

                width: 38
                height: 38

                radius: 19

                color: model.today ? "#c4a8ff" : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: model.day

                    color: model.today
                           ? "#000000"
                           : model.month === grid.month
                             ? "white"
                             : "#777777"
                }
            }
        }
    }
}