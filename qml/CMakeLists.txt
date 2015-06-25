set(COMPONENT_DIR lib/qt5/qml/Sailfish/Utilities)
set(JS_FILES
  tools.js
  )

set(QML_FILES
  ActionList.qml
  MainPage.qml
  )

install(
  FILES ${JS_FILES} ${QML_FILES}
  DESTINATION share/${PACKAGE_NAME}
  )

install(FILES qmldir ActionItem.qml DESTINATION ${COMPONENT_DIR})

add_custom_command(
    OUTPUT settings-sailfish_utilities.ts
    COMMAND lupdate . -ts settings-sailfish_utilities.ts
)
add_custom_target(ts_target ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/settings-sailfish_utilities.ts)

add_custom_command(
    OUTPUT settings-sailfish_utilities_eng_en.qm
    COMMAND lrelease -idbased settings-sailfish_utilities.ts -qm settings-sailfish_utilities_eng_en.qm
)
add_custom_target(qm_target ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/settings-sailfish_utilities_eng_en.qm)
add_dependencies(qm_target ts_target)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/settings-sailfish_utilities.ts DESTINATION share/translations/source)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/settings-sailfish_utilities_eng_en.qm DESTINATION share/translations)

add_subdirectory(plugins)
