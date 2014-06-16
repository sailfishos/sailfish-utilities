FILE(GLOB JS_FILES *.js)
FILE(GLOB QML_FILES *.qml)

install(
  FILES ${JS_FILES} ${QML_FILES} ${SVG_FILES}
  DESTINATION share/${PACKAGE_NAME}
  )

add_custom_command(
    OUTPUT sailfish-utilities.ts
    COMMAND lupdate . -ts sailfish-utilities.ts
)
add_custom_target(ts_target ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/sailfish-utilities.ts)

add_custom_command(
    OUTPUT sailfish-utilities_eng_en.qm
    COMMAND lrelease -idbased sailfish-utilities.ts -qm sailfish-utilities_eng_en.qm
)
add_custom_target(qm_target ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/sailfish-utilities_eng_en.qm)
add_dependencies(qm_target ts_target)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/sailfish-utilities.ts DESTINATION share/translations/source)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/sailfish-utilities_eng_en.qm DESTINATION share/translations)
