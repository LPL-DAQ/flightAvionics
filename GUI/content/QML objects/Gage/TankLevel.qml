import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
                id: fuel_percentage
                property string name: "DPF201"
                width: 500
                height: 22
                color: "#000000"
                
                function fetchNewVal() {
                text1.text = qsTr(bridge.updateGage(name))
                    }

                Text {
                    id: text
                    y: 4
                    color: "#ffffff"
                    text: qsTr("Fill: ")
                    anchors.left: parent.left
                    font.pixelSize: 18
                    anchors.leftMargin: 0
                }
                
                Text {
                    id: text1
                    y: 4
                    color: "#2ad12f"
                    text: qsTr("00")
                    anchors.left: parent.left
                    font.pixelSize: 18
                    anchors.leftMargin: 50
                }
                
                Text {
                    id: text2
                    y: 4
                    color: "#69eef0"
                    text: qsTr("%")
                    anchors.left: parent.left
                    font.pixelSize: 18
                    anchors.leftMargin: 120
                }
            }