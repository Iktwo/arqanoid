import QtQuick 2.0

Rectangle {
    id: playerBar
    width: 110
    height: 15

    radius: 20

    smooth: true

    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.darker(playerBar.color) }
        GradientStop { position: 0.5; color: Qt.lighter(playerBar.color) }
        GradientStop { position: 1.0; color: Qt.darker(playerBar.color) }
    }

    border.color: Qt.darker(playerBar.color)
    border.width: 2
}
