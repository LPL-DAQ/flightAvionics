import QtQuick 2.15

Rectangle {
                
    
    
    id: title_bar

    
    height: 30
    color: "#263551"
    border.color: "#ffffff"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.leftMargin: 0
    anchors.rightMargin: 0

    property string title: "Title"

    Text {
        id: text1
        color: "#ffffff"
        text: qsTr(title)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignLeft
        font.bold: true
        font.family: "Arial"
        anchors.horizontalCenter: parent.horizontalCenter
    }
}