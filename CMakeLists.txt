PROJECT(SAILFISH_UTILITIES)
cmake_minimum_required(VERSION 2.8)

set(prefix ${CMAKE_INSTALL_PREFIX})

set(PACKAGE_NAME sailfish-utilities)
set(DEPLOYMENT_PATH ${prefix}/share/${PACKAGE_NAME})

configure_file(utilities.json.in utilities.json @ONLY)
install(FILES utilities.json DESTINATION share/jolla-settings/entries)
install(
  FILES x-sailfish.sailfish-utilities.error.conf x-sailfish.sailfish-utilities.info.conf
  DESTINATION share/lipstick/notificationcategories
)

add_subdirectory(qml)
add_subdirectory(tools)
