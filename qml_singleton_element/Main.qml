import QtQuick
import SharedUtils.ColorUtils 1.0

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("C++ QML Singleton Element")

    Rectangle {
        id: textContainer
        anchors.centerIn: parent
        width: textChangeColor.paintedWidth + 16
        height: textChangeColor.paintedHeight + 16
        border.color: "gold"
        border.width: 2

        Text {
            id: textChangeColor
            anchors.centerIn: parent
            color: ColorUtils.randomColor()
            font.pointSize: 24
            font.bold: true
            text: qsTr("點擊變顏色")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textContainer.color = ColorUtils.randomColor()
                textChangeColor.color = ColorUtils.getTextColorByLuminance(textContainer.color)
            }
        }
    }
}
