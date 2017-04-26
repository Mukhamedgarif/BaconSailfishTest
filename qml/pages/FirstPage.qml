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
import QtSensors 5.0
import "components"

Page {
    allowedOrientations: Orientation.Landscape
    Game {
        id: game
        anchors.fill: parent

        height: parent.height
        width: parent.width

        gameName: "test"

        currentScene: gameScene

        Scene {
            id: gameScene
            //height: parent.height
            //width: parent.width
            physics: true
            anchors.fill: parent
            focus: true

            ImageLayer {
                id: back
                anchors.fill: parent
                source: "wp120dbcda_06.png"
                layerType: Layer.Infinite
            }

            ImageLayer {
                id: front
                anchors.fill: parent
                source: "clouds-png-5.png"
                layerType: Layer.Mirrored
                opacity: 0.5
                behavior: ScrollBehavior {
                    horizontalStep: -5
                }
            }

            PhysicsEntity {
                id: plane
                width: parent.width / 10
                height: parent.width / 20
                //x: parent.scene.width / 2 - spriteItem.width / 2
                //y: parent.scene.height / 2 - spriteItem.height / 2

                bodyType: Body.Dynamic
                sleepingAllowed: false
                gravityScale: 0

                Sprite {
                    anchors.fill: parent
                    animation: "falling"
                    animations: SpriteAnimation {
                        name: "falling"
                        source: "right.png"
                        frames: 1
                        duration: 450
                        loops: Animation.Infinite
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.destroy();
                    }
                }

                behavior: ScriptBehavior {
                    script: {
                        if (target.x > parent.parent.height)
                            target.x = 0;
                        if (target.x < 0)
                            target.x = parent.parent.height;
                        target.gravityScale = parent.x/parent.parent.width;

                        if (target.y > game.height / 2)
                            target.gravityScale = 0;
                        if (target.y < 0)
                            target.destroy();
                    }
                }
            }

            property int upAngle: 45
            property int downAngle: 45
            property int rightAngle: 45
            property int leftAngle: 45
            property int maxAngle: 170
            RotationSensor {
                id: rotationSensor
                active: true
                onReadingChanged: {
                    if(rotationSensor.reading.x >upAngle){

                        plane.applyLinearImpulse(
                                    Qt.point(10, 0),
                                    Qt.point(parent.x, parent.y));
                    }
                    if(rotationSensor.reading.y > leftAngle &&
                            rotationSensor.reading.y < maxAngle){
                        plane.applyLinearImpulse(
                                    Qt.point(-10, 0),
                                    Qt.point(parent.x, parent.y));

                    }
                    if(rotationSensor.reading.y > -maxAngle
                            && rotationSensor.reading.y < -rightAngle){
                           plane.angularVelocity += 10;
                    }
                    if(rotationSensor.reading.x < -downAngle){
                        plane.angularVelocity -= 10;
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                z: -1
                onClicked: {
                    if ((mouseX < game.height / 2) && (mouseY < 200))
                        plane.applyLinearImpulse(
                                    Qt.point(-10, 0),
                                    Qt.point(parent.x, parent.y));
                    if ((mouseX > game.height / 2) && (mouseY < 200))
                        plane.applyLinearImpulse(
                                    Qt.point(10, 0),
                                    Qt.point(parent.x, parent.y));
                    if ((mouseX < game.height / 2) && (mouseY > 500))
                        plane.angularVelocity += 10;
                    if ((mouseX > game.height / 2) && (mouseY > 500))
                        plane.angularVelocity -= 10;
                }
            }
        }
    }
}

