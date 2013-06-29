import QtQuick 1.1
import "UI.js" as UI

Rectangle {
    property int ballSpeed: 4
    property bool movingLeft: false
    property bool movingRight: false

    function isColliding(obj1, obj2) {
        return (obj1.x < obj2.x + obj2.width) && (obj1.y < obj2.y + obj2.height) && (obj1.x + obj1.width > obj2.x) && (obj1.y + obj1.height > obj2.y);
    }

    function reset(){
        ball.x = playerBar.x + (playerBar.width/2) - (ball.width/2)
        ball.y = playerBar.y - ball.height
        ball.goingUp = true
        ball.attached = true
    }

    function shoot(){
        ball.attached = false
    }

    function createBlock(x,y,color) {
        var component = Qt.createComponent("Block.qml");
        component.createObject(blocks,{"color": color,"x":x,"y":y});
    }

    anchors.fill: parent

    focus: true

    Keys.onPressed: {
        if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
            event.accepted = true;
            movingLeft = true
        }else if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
            event.accepted = true;
            movingRight = true
        }else if (event.key === Qt.Key_Space){
            event.accepted = true;
            shoot()
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
            event.accepted = true;
            movingLeft = false
        }else if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
            event.accepted = true;
            movingRight = false
        }
    }

    Component.onCompleted: {
        ball.color = UI.ball_colors[Math.floor((Math.random()*UI.ball_colors.length))]
        playerBar.color = UI.player_colors[Math.floor((Math.random()*UI.player_colors.length))]

        //Make sure the bar and the ball doesn't have the same color
        while(ball.color==playerBar.color){
            console.log("Color was the same, choosing a new color")
            ball.color = UI.ball_colors[Math.floor((Math.random()*UI.ball_colors.length))]
        }

        var color = UI.blocks_colors[Math.floor((Math.random()*UI.blocks_colors.length))]

        var j = -1;
        var l = 0;
        for (var i=0;i<55;i++){
            if (i%11==0){
                color = UI.blocks_colors[Math.floor((Math.random()*UI.blocks_colors.length))]
                j++;
                l = 0;
            }
            var x = (l*53) + (4*l) + 4
            l++;
            var y = 25*j //(i*53) + (4*i) + 4
            createBlock(x,y,color)
        }
    }

    Rectangle {
        id: blocks

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5

        height: game.height/3

    }

    PlayerBar {
        id: playerBar

        y: parent.height -height - 10
    }

    Ball {
        id: ball

        x: playerBar.x + (playerBar.width/2) - (ball.width/2)
        y: playerBar.y - ball.height
    }

    Timer {
        running: true
        repeat: true
        interval: 16

        onTriggered: {
            if (movingRight){
                if ((playerBar.x+playerBar.width+7)<= game.width){
                    playerBar.x += 7
                    if (ball.attached){
                        ball.x += 7
                    }
                }
            }
            if (movingLeft){
                if (playerBar.x > 6){
                    playerBar.x -= 7
                    if (ball.attached){
                        ball.x -= 7
                    }
                }
            }

            if (!ball.attached){
                //Move ball
                if (ball.goingRight){
                    if (ball.x < (game.width-ball.width-ballSpeed)){
                        ball.x += ballSpeed
                    }else{
                        ball.goingRight = false;
                    }
                }else{
                    if (ball.x > ballSpeed){
                        ball.x -= ballSpeed
                    }else{
                        ball.goingRight = true;
                    }
                }

                if (ball.goingUp){
                    if (ball.y > ballSpeed){
                        ball.y -= ballSpeed
                        // Check collision with blocks
                        //console.log("Blocks: "+blocks.children.length)
                        for (var i=0;i<blocks.children.length;i++){
                            var child = blocks.children[i];
                            if (isColliding(ball,child)){
                                ball.goingUp = false;
                                //ball.goingRight=!ball.goingRight // TODO: check this line
                                child.destroy();
                                //break;
                            }
                        }
                    }else{
                        ball.goingUp = false;
                    }
                }else{
                    if (ball.y < (game.height-ball.height-ballSpeed)){
                        ball.y += ballSpeed

                        if (ball.y>=(playerBar.y)){
                            reset()
                        }

                        if (ball.y>=game.height){
                            reset();
                        }

                        // Check collision with bar, with blocks

                        for (var i=0;i<blocks.children.length;i++){
                            var child = blocks.children[i];
                            if (isColliding(ball,child)){
                                ball.goingRight=!ball.goingRight
                                child.destroy();
                                //break;
                            }
                        }

                        if (isColliding(ball,playerBar)){
                            ball.goingUp = true
                        }

                    }
                }
            }
        }
    }
}
