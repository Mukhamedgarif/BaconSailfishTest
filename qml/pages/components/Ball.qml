import QtQuick 2.0
import Bacon2D 1.0

Component {

    PhysicsEntity {

        id: ballEntity
        height: 13
        width: 13

        bodyType: Body.Dynamic
        sleepingAllowed: false


        fixtures: Circle {
            radius: parent.width / 2
            density: 1
            friction: 0.5
            restitution: 0.2
        }

        Rectangle {
            // This is the drawn ball
            radius: parent.width / 2

            color: Qt.rgba(0.86, 0.28, 0.07, 1)  // #DD4814

            height: parent.height
            width: parent.width
        }
    }
}
