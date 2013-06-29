import QtQuick 1.1

Item {
    id: game

    width: 640
    height: 480

    Splashscreen { }

    Loader {
        id: loader

        anchors.fill: parent
        focus: true
        //visible: status == Loader.Ready
    }

    Timer {
        interval: 1500
        onTriggered: loader.source = "GameArea.qml"
        running: true
    }

    Component {
        id: gameArea

        GameArea { }
    }
}
