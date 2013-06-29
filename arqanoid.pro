greaterThan(QT_MAJOR_VERSION, 4): QT += quick
else: QT += declarative

SOURCES += \
    src/main.cpp

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    qml/QtQuick1/main.qml \
    qml/QtQuick1/UI.js \
    qml/QtQuick1/PlayerBar.qml \
    qml/QtQuick1/Block.qml \
    qml/QtQuick1/Ball.qml \
    qml/QtQuick2/main.qml \
    qml/QtQuick2/UI.js \
    qml/QtQuick2/PlayerBar.qml \
    qml/QtQuick2/Block.qml \
    qml/QtQuick2/Ball.qml \
    qml/QtQuick2/GameArea.qml \
    qml/QtQuick2/Splashscreen.qml \
    qml/QtQuick1/Splashscreen.qml \
    qml/QtQuick1/GameArea.qml
