TEMPLATE = aux

PROJECTS = qml plugin qml/plugins tools

message($${PROJECTS})
OTHER_FILES += *.qml *.js *.txt qmldir
HEADERS += *.h
SOURCES += *.cpp
for (PROJECT, PROJECTS) {
    OTHER_FILES += $${PROJECT}/*.qml \
                   $${PROJECT}/*.js \
                   $${PROJECT}/*.txt \
                   $${PROJECT}/qmldir \
                   $${PROJECT}/*.sh \
                   $${PROJECT}/*.in
    HEADERS += $${PROJECT}/*.h
    SOURCES += $${PROJECT}/*.cpp
}
