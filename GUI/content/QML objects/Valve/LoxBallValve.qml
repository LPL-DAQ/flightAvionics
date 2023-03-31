// SquareButton.qml
import QtQuick 2.0


Rectangle {
    id: rectangle
    x: 195
    y: 356
    width: 50
    height: 50
    color: "#00ffffff"
    radius: width
    border.width: 0
    property real ang_Open: 0
    property string name: "SVH001"

    state: "OD"

    states: [
        State {
            name: "OA"
            PropertyChanges { target: icon_image; source: "ArmedBall.png"}
        },
        State {
            name: "OD"
            PropertyChanges { target: icon_image; source: "LoxBall_Open.png"}
        },
        State {
            name: "CA"
            PropertyChanges { target: icon_image; source: "ArmedBall.png"}
        },
        State {
            name: "CD"
            PropertyChanges { target: icon_image; source: "ClosedBall.png"}
        }
    ]

    function update() {
        if (bridge.getValveState(name)) {
            if(bridge.getArmState(name)){
                rectangle.state = "OA"
            }else{
                rectangle.state = "OD"
            }
        }else{
            if(bridge.getArmState(name)){
                rectangle.state = "CA"
            }else{
                rectangle.state = "CD"
            }
        }
    }

    Image {
        id: icon_image
        x: 0
        y: 0
        source: "ArmedBall.png"
        rotation: parent.ang_Open
        fillMode: Image.PreserveAspectFit
        width: 61
        height: 32
    }
}



/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}
}
##^##*/
