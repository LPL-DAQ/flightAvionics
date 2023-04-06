import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
                id: fuel_percentage
                property string name: "DPF201"
                width: 63
                height: 22
                color: "#000000"
                
                function fetchNewVal() {
                text1.text = qsTr(bridge.updateGage(name))
                    }
                
                Text {
                    id: text1
                    y: 4
                    color: "#2ad12f"
                    text: qsTr("00")
                    anchors.left: parent.left
                    font.pixelSize: 18
                    anchors.leftMargin: 10
                }
                
                Text {
                    id: text2
                    x: 32
                    y: 4
                    color: "#69eef0"
                    text: qsTr("%")
                    anchors.right: parent.right
                    font.pixelSize: 18
                    anchors.rightMargin: 5
                }
            }