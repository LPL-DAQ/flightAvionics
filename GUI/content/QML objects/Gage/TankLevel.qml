import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
                id: fuel_percentage
                property string name: "DPF201"
                width: 80
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
                    text: qsTr("Fill")
                    font.pixelSize: 20
                }
                
                Text {
                    id: text1
                    y: 4
                    color: "#2ad12f"
                    text: qsTr("00")
                    anchors.left: parent.left
                    font.pixelSize: 20
                    anchors.leftMargin: 40
                }
                
                Text {
                    id: text2
                    x: 32
                    y: 4
                    color: "#69eef0"
                    text: qsTr("%")
                    anchors.right: parent.right
                    font.pixelSize: 20
                    anchors.rightMargin: 2
                }
            }