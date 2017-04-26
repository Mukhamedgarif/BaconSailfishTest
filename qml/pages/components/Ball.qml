import QtQuick 2.0
import Bacon2D 1.0

Component {

    PhysicsEntity {


        id: ballEntity

        //height: 300
        //width: 600

        Sprite {
            animation: "idle"

            animations: SpriteAnimation {
                name: "idle"
                source: "right.png"
                frames: 1
                duration: 400
                loops: Animation.Infinite
            }
        }

        bodyType: Body.Dynamic
        sleepingAllowed: false
        bullet: true
        gravityScale: 0.2
        //linearVelocity: Item.linearVelocity.setX(1.0)


        fixtures: Circle {
            radius: parent.width / 2
            density: 1
            friction: 0.5
            restitution: 0.2
        }

        Rectangle {
            // This is the drawn ball
            //radius: parent.width / 2

            //color: Qt.rgba(0.86, 0.28, 0.07, 1)  // #DD4814

            height: parent.height
            width: parent.width
        }
    }
}
