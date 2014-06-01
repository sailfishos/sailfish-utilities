PROJECT(SAILFISH_TINY_TOOLS)
cmake_minimum_required(VERSION 2.8)

install(FILES utilities.json DESTINATION share/jolla-settings/entries)
install(FILES sailfish-tiny-tools.desktop DESTINATION share/applications)
set(prefix ${CMAKE_INSTALL_PREFIX})

set(DEPLOYMENT_PATH ${prefix}/share/sailfish-tiny-tools/)
find_package(Qt5Core REQUIRED)
set(CMAKE_AUTOMOC TRUE)

set(CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS} -DDEPLOYMENT_PATH=\"\\\"\"${DEPLOYMENT_PATH}\"\\\"\" -fPIC -W -Wall -Wextra -Werror -g -O2 -std=c++0x")

#-Wno-psabi is to remove next g++ warning/note:
#the mangling of 'va_list' has changed in GCC 4.4
set(CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS} -Wno-psabi")

include_directories(
  ${PROJECT_SOURCE_DIR}/sailfishapplication
  )

find_package(PkgConfig REQUIRED)
pkg_check_modules(BOOSTABLE qdeclarative5-boostable)
if (BOOSTABLE_FOUND)
  message(STATUS "Using qdeclarative5-boostable")
  include_directories(${BOOSTABLE_INCLUDE_DIRS})
  link_directories(${BOOSTABLE_LIBRARY_DIRS})
  add_definitions(-DHAS_BOOSTER ${BOOSTABLE_CFLAGS_OTHER})
  
  add_library(sailfish-tiny-tools MODULE
    main.cpp
    sailfishapplication/sailfishapplication.cpp
    )
  set_target_properties(sailfish-tiny-tools PROPERTIES PREFIX "" SUFFIX "")
else (BOOSTABLE_FOUND)
  add_executable(sailfish-tiny-tools
    main.cpp
    sailfishapplication/sailfishapplication.cpp
    )
endif (BOOSTABLE_FOUND)

if (BOOSTABLE_FOUND)
  target_link_libraries(sailfish-tiny-tools ${BOOSTABLE_LIBRARIES})
endif (BOOSTABLE_FOUND)
qt5_use_modules(sailfish-tiny-tools Core Qml Quick Gui)
install(TARGETS sailfish-tiny-tools DESTINATION bin)

add_subdirectory(qml)
add_subdirectory(tools)
