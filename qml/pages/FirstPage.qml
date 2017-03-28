/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Bacon2D 1.0
import "components"

Page {
    Game {
        id: game
        anchors.centerIn: parent

        height: 680
        width: 440

        gameName: "test"

        currentScene: gameScene

        Scene {
            id: gameScene
            physics: true
            //running: true

            anchors.fill: parent

            Bowl {
                id: bowl
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Ball {
                id: ball
            }
/*
            PhysicsEntity {
                id: door
                height: 10
                width: 62.5       // This is the width of the bottleneck of the bowl
                anchors.top: bowl.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                fixtures: Box {

                    //anchors.fill: parent
                    sensor: isDoorOpen
                    Edge {
                        vertices: [
                            Qt.point(0, 0),
                            Qt.point(width, 0)
                        ]
                    }
                }

                Canvas {
                    id: canvas
                    visible: !isDoorOpen    // When the user clicks, hide this

                    anchors.fill: parent

                    onPaint: {
                        var context = canvas.getContext("2d");
                        context.beginPath();
                        context.lineWidth = 5;

                        context.moveTo(0, 0);
                        context.lineTo(width, 0);

                        context.strokeStyle = "black";
                        context.stroke();
                    }
                }
            }

            MouseArea {
                    anchors.fill: parent
                    onPressed: isDoorOpen = true;
                    onReleased: isDoorOpen = false;
                }
*/
            Component.onCompleted: {
                for (var i = 0; i < 10; i++) {
                    for (var j = 0; j < 10; j++) {
                        var newBox = ball.createObject(gameScene);
                        newBox.x = gameScene.width / 2 - 100 + 15*j;
                        newBox.y = (15*i) - 10;
                    }
                }
            }
        }
    }
}

