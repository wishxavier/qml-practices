cmake_minimum_required(VERSION 3.16)

project(qml_javascript_singleton VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appqml_javascript_singleton
    main.cpp
)

set_source_files_properties(resources/qml_utils/color_utils.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
        QT_QML_SOURCE_TYPENAME "ColorUtils"
)

qt_add_qml_module(appqml_javascript_singleton
    URI qml_javascript_singleton
    VERSION 1.0
    QML_FILES
        Main.qml
        resources/qml_utils/color_utils.qml
    RESOURCES
        resources/javascripts/color_utils.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqml_javascript_singleton PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqml_javascript_singleton
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml_javascript_singleton
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqml_javascript_singleton
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
