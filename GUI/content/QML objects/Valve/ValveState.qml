import QtQuick 2.0

Rectangle {
    id: valve_state
    x: 1289
    y: 275
    width: 85
    height: 62
    color: "#00ffffff"
    border.color: "#00000000"
    property string state: "CLOSED"
    property string text_color: "#ff0000"
    property string name: "SVH001"
                
    Text {
        id: text4
        x: 0
        width: 85
        height: 29
        color: "#ffffff"
        text: qsTr(name)
        anchors.top: parent.top
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        anchors.topMargin: 2
        font.bold: false
        }

    Text {
        id: text5
        x: 0
        width: 85
        text: qsTr(valve_state.state)
        color: qsTr(text_color)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        anchors.bottomMargin: 0
        anchors.topMargin: 32
        font.bold: false
        }

    function update() {
        if (bridge.getValveState(name)) {
            valve_state.state = "OPENED"
            valve_state.text_color = "#10ff00"
        }else{
            valve_state.state = "CLOSED"
            valve_state.text_color = "#ff0000"
        }
    }

 }





/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}
}
##^##*/
