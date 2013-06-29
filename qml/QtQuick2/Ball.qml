import QtQuick 2.0

Rectangle {
    id: ball

    property bool attached: true
    property bool goingRight: true
    property bool goingUp: true

    width: 15
    height: 15

    radius: 15

    smooth: true

    /*gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.darker(ball.color) }
        GradientStop { position: 0.5; color: Qt.lighter(ball.color) }
        GradientStop { position: 1.0; color: Qt.darker(ball.color) }
    }*/
}
