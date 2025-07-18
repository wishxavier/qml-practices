pragma Singleton
import QtQuick 2.12
import "qrc:/qt/qml/qml_javascript_singleton/resources/javascripts/color_utils.js" as ColorUtils

QtObject {
    function getTextColorByLuminance(rgba) {
        return ColorUtils.getTextColorByLuminance(rgba)
    }

    function randomColor() {
        return ColorUtils.randomColor()
    }
}
