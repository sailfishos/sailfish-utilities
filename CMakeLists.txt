PROJECT(SAILFISH_TINY_TOOLS)
cmake_minimum_required(VERSION 2.8)

install(FILES utilities.json DESTINATION share/jolla-settings/entries)
set(prefix ${CMAKE_INSTALL_PREFIX})

set(DEPLOYMENT_PATH ${prefix}/share/sailfish-tiny-tools/)

add_subdirectory(qml)
add_subdirectory(tools)
