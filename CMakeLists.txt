PROJECT(SAILFISH_UTILITIES)
cmake_minimum_required(VERSION 3.10)

set(prefix ${CMAKE_INSTALL_PREFIX})

set(PACKAGE_NAME sailfish-utilities)
set(DEPLOYMENT_PATH ${prefix}/share/${PACKAGE_NAME})

configure_file(utilities.json.in utilities.json @ONLY)
install(FILES utilities.json DESTINATION share/jolla-settings/entries)

add_subdirectory(qml)
add_subdirectory(plugin)
add_subdirectory(tools)
