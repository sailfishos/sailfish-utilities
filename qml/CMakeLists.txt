FILE(GLOB JS_FILES *.js)
FILE(GLOB QML_FILES *.qml)

install(
  FILES ${JS_FILES} ${QML_FILES} ${SVG_FILES}
  DESTINATION share/sailfish-tiny-tools
  )
