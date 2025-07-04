import QtQuick

Window {
    id: mainWindow
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello Qt Quick")

    Rectangle {
        id: mainRect
        anchors.fill: parent
        color: "black"

        Text {
            id: helloText
            text: qsTr("Hello QML!")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            font.pointSize : 24
            color: "skyblue"
        }

        Text {
            id: nameText
            text: qsTr("Wish")
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
            font.pointSize : 24
            color: "aqua"
        }
    }
}
