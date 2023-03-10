import QtQuick 2.0


Rectangle {
    id: rectangle
    x: 195
    y: 356
    width: 10
    height: 56
    color: "#00ffffff"
    radius: width
    border.width: 0
    property real ang_Open: 0
    property string name: "SVH001"

    state: "ARMED"

    states: [
        State {
            name: "ARMED"
            PropertyChanges { target: icon_image; source: "RegulatorArm.png"}
        },
        State {
            name: "NOTARMED"
            PropertyChanges { target: icon_image; source: "Regulator.png"}
        }
    ]

    function update() {
        if(bridge.getArmState(name)){
            rectangle.state = "ARMED"
        }else{
            rectangle.state = "NOTARMED"
        }
    }

    Image {
        id: icon_image
        x: 0
        y: 0
        source: "Regulator.png"
        rotation: parent.ang_Open
        height: 56
        width: 42
    }
}



/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}
}
##^##*/
