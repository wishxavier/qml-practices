﻿cmake_minimum_required(VERSION 3.16)
project(QmlPractices)

find_package(Qt6 REQUIRED COMPONENTS Quick Gui)
qt_standard_project_setup(REQUIRES 6.8)

# Merge .gitignore.core and .gitignore.ide into a single .gitignore file
file(READ "${CMAKE_SOURCE_DIR}/.gitignore.core" CORE_CONTENT)
file(READ "${CMAKE_SOURCE_DIR}/.gitignore.ide" IDE_CONTENT)
file(WRITE "${CMAKE_SOURCE_DIR}/.gitignore" "${CORE_CONTENT}\n\n${IDE_CONTENT}")
message(STATUS "[CMake] .gitignore generated from templates.")

# Enable Qt QML automatic features
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# for shared libraries
add_subdirectory(shared_utils)

# Include QML modules
add_subdirectory(qml-hello)
# add_subdirectory(qml_interaction)
add_subdirectory(qml_javascript_inline)
add_subdirectory(qml_javascript_import)
add_subdirectory(qml_javascript_singleton)
add_subdirectory(qml_singleton_element)

# Add more modules below as needed:
# add_subdirectory(qml_basic)
