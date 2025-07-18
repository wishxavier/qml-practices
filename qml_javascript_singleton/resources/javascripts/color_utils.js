.pragma library

function getLuminance(rgba) {
    const RsRGB = rgba.r
    const GsRGB = rgba.g
    const BsRGB = rgba.b

    function channelLum(c) {
        return c <= 0.03928
            ? c / 12.92
            : Math.pow((c + 0.055) / 1.055, 2.4)
    }

    const R = channelLum(RsRGB)
    const G = channelLum(GsRGB)
    const B = channelLum(BsRGB)
    return 0.2126 * R + 0.7152 * G + 0.0722 * B
}

function getTextColorByLuminance(rgba) {
    const luminance = getLuminance(rgba)
    return luminance > 0.5 ? "black" : "white"
}

function randomColor() {
    return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0)
}
