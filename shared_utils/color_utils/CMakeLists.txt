cmake_minimum_required(VERSION 3.16)

add_library(ColorUtils INTERFACE)

target_include_directories(ColorUtils
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_link_libraries(ColorUtils
    INTERFACE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
)

# QML 模組庫（用於註冊）
qt_add_library(QmlColorUtils STATIC)

qt_add_qml_module(QmlColorUtils
    URI "SharedUtils.ColorUtils"
    VERSION 1.0
    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/SharedUtils/ColorUtils"
    SOURCES
        color_utils.hpp
)

target_link_libraries(QmlColorUtils
    PUBLIC
        ColorUtils
        QmlColorUtilsplugin
)

# Alias 提供命名空間
add_library(SharedUtils::ColorUtils ALIAS QmlColorUtils)
