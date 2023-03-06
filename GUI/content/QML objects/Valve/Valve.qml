// SquareButton.qml
import QtQuick 2.0


Rectangle {
    id: rectangle
    x: 195
    y: 356
    width: 50
    height: 50
    color: "#0c182e"
    radius: width
    border.width: 0
    property real ang_Open: 0
    property string name: "SVH001"

    state: "OD"

    states: [
        State {
            name: "OA"
            PropertyChanges { target: icon_image; rotation: rectangle.ang_Open}
            PropertyChanges { target: icon_image; source: "valve_orange.png"}
        },
        State {
            name: "OD"
            PropertyChanges { target: icon_image; rotation: rectangle.ang_Open}
            PropertyChanges { target: icon_image; source: "valve_green.png"}
        },
        State {
            name: "CA"
            PropertyChanges { target: icon_image; rotation: rectangle.ang_Open+90}
            PropertyChanges { target: icon_image; source: "valve_orange.png"}
        },
        State {
            name: "CD"
            PropertyChanges { target: icon_image; rotation: rectangle.ang_Open+90}
            PropertyChanges { target: icon_image; source: "valve_white.png"}
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
        source: "valve_green.png"
        
        rotation: parent.ang_Open
        fillMode: Image.PreserveAspectFit


    }
}



/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}
}
##^##*/
