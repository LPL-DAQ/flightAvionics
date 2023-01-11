import QtQuick 2.15

Rectangle {
    id: valve_ctrl

    x: 0
    y: 0
    width: 208



    height: 65
    color: "#00ff0000"
    border.color: "#7f5d5d"
    border.width: 0

    property string name: "SVH001"
    property bool isOpen: false
    property bool nrml_Opn: true

    function update() {
        if (bridge.getValveState(name)) {
            opn_txt.state = "open"
            if(valve_ctrl.nrml_Opn){
                pwr_txt.state = "off"
            }else{
                pwr_txt.state = "on"
            }
        }else{
            opn_txt.state = "closed"
            if(valve_ctrl.nrml_Opn){
                pwr_txt.state = "on"
            }else{
                pwr_txt.state = "off"
            }
        }
    }

    Item {
        id: indicator
        width: 101
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0



        Rectangle {
            id: rectangle10
            height: parent.height/2
            color: "#000000"
            border.color: "#bebebe"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Text {
                id: opn_txt
                color: "#7f7f7f"
                text: qsTr("OPEN")
                anchors.fill: parent
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                styleColor: "#2ad12f"
                font.family: "Arial"

                state: "open"

                states: [
                    State {
                        name: "open"
                        PropertyChanges { target: opn_txt; color: "#2ad12f"}
                        PropertyChanges { target: opn_txt; text: qsTr("OPEN")}
                    },
                    State {
                        name: "closed"
                        PropertyChanges { target: opn_txt; color: "#7f7f7f"}
                        PropertyChanges { target: opn_txt; text: qsTr("CLOSED")}
                    }
                ]
            }
        }

        Rectangle {
            id: rectangle11
            color: "#000000"
            border.color: "#bebebe"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangle10.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Text {
                id: pwr_txt
                color: "#69eef0"
                text: qsTr("PWR ON")
                anchors.fill: parent
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                styleColor: "#69eef0"
                font.family: "Arial"

                state: "on"

                states: [
                    State {
                        name: "on"
                        PropertyChanges { target: pwr_txt; color: "#69eef0"}
                        PropertyChanges { target: pwr_txt; text: qsTr("PWR ON")}
                    },
                    State {
                        name: "off"
                        PropertyChanges { target: pwr_txt; color: "#7f7f7f"}
                        PropertyChanges { target: pwr_txt; text: qsTr("PWR OFF")}
                    }
                ]
            }
        }
    }

    Item {
        id: toggle
        x: 0
        y: 0
        width: 101
        height: 65
        layer.enabled: true
        smooth: true

        state: "off"

        property bool on: false


        function toggle() {
            if (toggle.state === "on"){
                toggle.state = "off";
                bridge.armValve(valve_ctrl.name,"nil");
            }else{
                toggle.state = "on";
                bridge.armValve(valve_ctrl.name,"ARMED");
            }
        }

        states: [
            State {
                name: "on"
                PropertyChanges { target: rectangle1; color: "#d9a637"}
                PropertyChanges { target: rectangle2; color: "#d9a637"}
                PropertyChanges { target: rectangle3; color: "#d9a637"}
                PropertyChanges { target: toggle; on: true }
            },
            State {
                name: "off"
                PropertyChanges { target: rectangle1; color: "#dbdbdb"}
                PropertyChanges { target: rectangle2; color: "#dbdbdb"}
                PropertyChanges { target: rectangle3; color: "#dbdbdb"}
                PropertyChanges { target: toggle; on: false }
            }
        ]

        Rectangle {
            id: rectangle
            color: "#555555"
            border.color: "#ffffff"
            anchors.fill: parent
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
        }

        MouseArea { anchors.fill: parent; onClicked: toggle.toggle() }

        Text {
            id: text1
            x: 17
            y: 38
            width: 67
            height: 23
            color: "#ffffff"
            text: qsTr(valve_ctrl.name)
            anchors.bottom: valve_ctrl.bottom
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 4
            anchors.horizontalCenterOffset: 0
            font.family: "Arial"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            id: btn_bg
            property int strips_height: 7
            x: 6
            y: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: text1.top
            anchors.leftMargin: 6
            anchors.rightMargin: 6
            anchors.topMargin: 5
            anchors.bottomMargin: 0

            Rectangle {
                id: rectangle1
                x: 0
                y: 0
                height: parent.strips_height
                color: "#dbdbdb"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: rectangle2.top
                anchors.bottomMargin: 3
                anchors.rightMargin: 0
                anchors.leftMargin: 0
            }

            Rectangle {
                id: rectangle2
                x: 0
                height: parent.strips_height
                color: "#dbdbdb"
                anchors.verticalCenter: parent.verticalCenter

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.leftMargin: 0
            }

            Rectangle {
                id: rectangle3
                x: 0
                height: parent.strips_height
                color: "#dbdbdb"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangle2.bottom
                anchors.topMargin: 3
                anchors.rightMargin: 0
                anchors.leftMargin: 0
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;height:65;width:101}D{i:3}D{i:2}D{i:11}D{i:10}D{i:1}D{i:29}D{i:30}D{i:31}D{i:33}
D{i:34}D{i:35}D{i:32}D{i:18}
}
##^##*/
