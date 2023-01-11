import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
    id: reading
    property string name: "XXX000"
    width: 180
    height: 31



    property string value: "0000.00"
    property string unit: "PSI"

    function fetchNewVal() {
        text2.text = qsTr(bridge.updateGage(name))
    }


    padding: 5
    layoutDirection: Qt.LeftToRight

    Text {
        id: text1
        color: "#ffffff"
        text: qsTr(name + ":")
        font.pixelSize: 17
        rightPadding: 0
        font.family: "Arial"
    }

    Text {
        id: text2
        width: 74
        color: "#2ad12f"
        text: qsTr(value)
        font.pixelSize: 17
        horizontalAlignment: Text.AlignRight
        rightPadding: 6
        font.family: "Arial"
    }

    Text {
        id: text3
        color: "#69eef0"
        text: qsTr(unit)
        font.pixelSize: 17
        horizontalAlignment: Text.AlignHCenter
        font.family: "Arial"
    }
}
/*##^##
Designer {
    D{i:0;height:31;width:180}D{i:1}D{i:2}D{i:3}
}
##^##*/
