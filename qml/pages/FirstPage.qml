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
    allowedOrientations: Orientation.Landscape
    Game {
        id: game
        anchors.fill: parent

        height: 720
        width: 1280

        gameName: "test"

        currentScene: gameScene

        Scene {
            id: gameScene
            height: 720
            width: 1280
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
                property int velocity: 0
                id: plane_base

                x: 100
                y: 100
                width: 1
                height: 1
                Rectangle {
                    width: 10
                    height: 10
                    color: "#DEDEDE"
                }
                bodyType: Body.Kinematic
                sleepingAllowed: false
                gravityScale: 0
                fixtures: Box {
                    id: baseFixture
                    //width: plane_base.width
                    //height: plane_base.height
                    density: 0.5
                }

            }

            PhysicsEntity {
                property int velocity: 0
                id: plane
                width: 216
                height: 108
                x: 100
                y: 100
                //x: parent.scene.width / 2 - spriteItem.width / 2
                //y: parent.scene.height / 2 - spriteItem.height / 2

                bodyType: Body.Dynamic
                sleepingAllowed: false
                gravityScale: 0

                fixtures: Box {
                    id: planeFixture
                    width: plane.width
                    height: plane.height
                    density: 0.5
                }

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
                        //parent.destroy();
                    }
                }

                behavior: ScriptBehavior {
                    script: {
                        var angle = joint.getJointAngle();
                        plane.linearVelocity.y =  plane.velocity * Math.sin(angle * Math.PI / 180);
                        plane.linearVelocity.x = plane.velocity * Math.cos(angle * Math.PI / 180);
                        plane_base.linearVelocity = plane.linearVelocity;

                        if (plane.x > 1280) {
                            plane.x = 0;
                            plane_base.x = 0;
                        }
                        if (plane.x < 0) {
                            plane.x = 1280;
                            plane_base.x = 1280;
                        }

                        if (plane.y < - plane.width * Math.sin(angle * Math.PI / 180)) {
                            plane.linearVelocity.y = 10;
                            plane_base.linearVelocity.y = 10;
                        }
                        if (plane.y > game.height - plane.width * Math.sin(angle * Math.PI / 180)) {
                            plane.destroy();
                            plane_base.destroy();
                        }

                        console.log(plane.width * Math.sin(angle * Math.PI / 180));
                    }
                }
            }

            RevoluteJoint {
                id: joint
                bodyA: plane_base.body
                bodyB: plane.body
                collideConnected: false
                motorSpeed: 0
                enableMotor: false
                maxMotorTorque: 10000
                //enableLimit: false
                //lowerAngle: 60
                //upperAngle: -60
            }

            MouseArea {
                anchors.fill: parent
                z: -1
                onPressed: {
                    if ((mouseX < game.height / 2) && (mouseY < 200) && (plane.linearVelocity.x > 0)) {
                        plane.velocity -= 20;
                        plane_base.velocity -= 20;
                    }
                    if ((mouseX > game.height / 2) && (mouseY < 200)) {
                        plane.velocity += 20;
                        plane_base.velocity += 20;
                    }
                    if ((mouseX < game.height / 2) && (mouseY > 500)) {
                        joint.motorSpeed = 500;
                        joint.enableMotor = true;
                    }

                    if ((mouseX > game.height / 2) && (mouseY > 500)) {
                        joint.motorSpeed = -500;
                        joint.enableMotor = true;
                    }
                }

                onReleased: {
                    //plane.applyLinearImpulse(Qt.point(-(plane.linearVelocity.x), -(plane.linearVelocity.y)), Qt.point(plane.x, plane.y));
                    joint.motorSpeed = 0;
                }

            }
        }
    }
}

