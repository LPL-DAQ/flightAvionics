import QtQuick 2.15


Item {
    id: header
    x: 0
    y: 0
    width: 488
    height: 43
    property string hederText: "Header"

    Rectangle {
        id: rectangle1
        height: 3
        color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: text3.left
        anchors.rightMargin: 10
        anchors.leftMargin: 20
    }

    Text {
        id: text3
        color: "#ffffff"
        text: qsTr(parent.hederText)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: false
    }

    Rectangle {
        id: rectangle2
        y: 42
        height: 3
        color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: text3.right
        anchors.right: parent.right
        anchors.verticalCenterOffset: 0
        anchors.rightMargin: 20
        anchors.leftMargin: 10
    }
}
/*##^##
Designer {
    D{i:0;height:43;width:490}D{i:1}D{i:2}D{i:3}
}
##^##*/
