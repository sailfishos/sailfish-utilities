project(sailfishutilitiesplugin)

include(GNUInstallDirs)

set(COMPONENT_DIR ${CMAKE_INSTALL_LIBDIR}/qt5/qml/Sailfish/Utilities)

install(FILES qmldir ActionItem.qml DESTINATION ${COMPONENT_DIR})

find_package(Qt5Quick)

set(plugin_SRCS plugin.cpp utiltools.cpp)
set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_library(sailfishutilitiesplugin MODULE ${plugin_SRCS})

target_link_libraries(sailfishutilitiesplugin Qt5::Quick)

install(TARGETS sailfishutilitiesplugin DESTINATION ${COMPONENT_DIR})

