PROJECT(SAILFISH_TINY_TOOLS)
cmake_minimum_required(VERSION 2.8)

install(FILES sailfish-tiny-tools.desktop DESTINATION share/applications)
set(prefix ${CMAKE_INSTALL_PREFIX})

add_subdirectory(qml)
add_subdirectory(tools)
