import QtQuick 2.0

Item {
    id: game

    width: 640
    height: 480

    Splashscreen { }

    Loader {
        id: loader

        anchors.fill: parent
        asynchronous: true
        focus: true
        visible: status == Loader.Ready


        onProgressChanged: console.log("Progress", progress)
    }

    Timer {
        interval: 1500
        onTriggered: loader.source = "GameArea.qml"
        running: true
    }
}
