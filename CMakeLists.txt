cmake_minimum_required(VERSION 3.16)
project(QmlPractices)

# 開啟 QML 支援
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# 加入每個子專案
add_subdirectory(qml-hello)
add_subdirectory(qml-basic)
# 未來新增：
# add_subdirectory(qml-interaction)

# 可加入共用資料夾
# add_subdirectory(shared)