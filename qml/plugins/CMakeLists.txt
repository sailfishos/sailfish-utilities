FILE(GLOB QML_FILES *.qml)

install(
  FILES ${QML_FILES}
  DESTINATION share/${PACKAGE_NAME}/plugins
  )
