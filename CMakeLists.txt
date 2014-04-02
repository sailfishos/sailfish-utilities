PROJECT(SAILFISH_TINY_TOOLS NONE)
cmake_minimum_required(VERSION 2.8)

install(FILES sailfish-tiny-tools.desktop DESTINATION share/applications)

add_subdirectory(qml)
add_subdirectory(tools)
