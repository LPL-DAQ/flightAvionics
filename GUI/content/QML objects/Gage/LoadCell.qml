import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
                id: fuel_percentage
                property string name: "LC001"
                width: 300
                height: 22
                color: "#000000"
                
                function fetchNewVal() {
                text1.text = qsTr(bridge.updateGage(name))
                    }

                Text{
                    id: text3
                    y: 4
                    x: 0
                    color: "#ffffff"
                    text: qsTr("FORCE:")
                    font.pixelSize: 30
                }
                
                Text {
                    id: text1
                    y: 4
                    color: "#2ad12f"
                    text: qsTr("0000.00")
                    anchors.left: parent.left
                    font.pixelSize: 30
                    anchors.leftMargin: 140
                }
                
                Text {
                    id: text2
                    x: 32
                    y: 4
                    color: "#69eef0"
                    text: qsTr("N")
                    anchors.right: parent.right
                    font.pixelSize: 30
                    anchors.rightMargin: 2
                }
            }