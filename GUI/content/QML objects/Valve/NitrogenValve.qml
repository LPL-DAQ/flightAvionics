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
    property bool nrm_Opn: false

    state: "OD"

    states: [
        State {
            name: "OA"
            PropertyChanges { target: icon_image; source: "ArmedValve.png"}
        },
        State {
            name: "OD"
            PropertyChanges { target: icon_image; source: "OpenValve_Nitrogen.png"}
        },
        State {
            name: "CA"
            PropertyChanges { target: icon_image; source: "ArmedValve.png"}
        },
        State {
            name: "CD"
            PropertyChanges { target: icon_image; source: "ClosedValve.png"}
        }
    ]

    function update() {
        if (bridge.getValveState(name)) {
            if(bridge.getArmState(name)){
                if (rectangle.nrm_Opn){
                    rectangle.state = "CA"
                }
                else{
                    rectangle.state = "OA"  
                }
                
            }else{
                if (rectangle.nrm_Opn){
                    rectangle.state = "CD"
                }
                else{
                    rectangle.state = "OD"
                }
                
            }
        }else{
            if(bridge.getArmState(name)){
                if (rectangle.nrm_Opn){
                    rectangle.state = "OA"
                }
                else{
                    rectangle.state = "CA"
                }
            }else{
                if (rectangle.nrm_Opn){
                    rectangle.state = "OD"
                }
                else{
                    rectangle.state = "CD"
                }
                
            }
        }
    }

    Image {
        id: icon_image
        x: 0
        y: 0
        source: "ArmedBall.png"
        rotation: parent.ang_Open
        width: 57
        height: 36
    }
}



/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}
}
##^##*/
