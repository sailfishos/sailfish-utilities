TEMPLATE = aux

PROJECTS = qml plugin qml/plugins

message($${PROJECTS})
OTHER_FILES += *.qml *.js
for (PROJECT, PROJECTS) {
    OTHER_FILES += $${PROJECT}/*.qml \
                   $${PROJECT}/*.js
}
j
