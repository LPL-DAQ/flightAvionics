import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts
import "content/Images"
import "content/QML objects/Gage"
import "content/QML objects/Valve"
import "content/QML objects/visual elements"



Item {
    id: window
    width: 2560*dpi_scale
    height: 1440*dpi_scale
    visible: true
    property real dpi_scale: 0.6
    scale: 1

    function updateElements() {



        // Refresh Helium PTs
        pth001.fetchNewVal()
        pth002.fetchNewVal()
        pth003.fetchNewVal()
        pth004.fetchNewVal()
        pth005.fetchNewVal()
        pth006.fetchNewVal()

        // Refresh LOx PTs
        pto101.fetchNewVal()
        pto102.fetchNewVal()
        pto103.fetchNewVal()
        pto404.fetchNewVal()

        // Refresh Kerosene PTs
        ptf201.fetchNewVal()
        ptf202.fetchNewVal()
        ptf203.fetchNewVal()
        ptf204.fetchNewVal()
        ptf401.fetchNewVal()
        ptf402.fetchNewVal()
        ptf403.fetchNewVal()
        
        // Refresh Helium TCs
        tch001.fetchNewVal()
        tch002.fetchNewVal()
        tch003.fetchNewVal()

        // Refresh LOX TCs
        tco101.fetchNewVal()
        tco102.fetchNewVal()
        tco103.fetchNewVal()
        tco104.fetchNewVal()

        // Refresh Kerosene TCs
        tcf201.fetchNewVal()
        tcf203.fetchNewVal()
        tcf401.fetchNewVal()
        tcf402.fetchNewVal()

        // Chamber PTs
        ptc405.fetchNewVal()
        ptc406.fetchNewVal()

        //Tank Tank Level
        dpf201.fetchNewVal()

        svh001t.update()
        svh002t.update()
        svh003t.update()
        svh004t.update()

        svo101t.update()
        svo102t.update()

        svf201t.update()
        pbvf201t.update()
        svf204t.update()
        cpf201t.update()
        ebvo102t.update()
        bvo101t.update()

        svh001.update()
        svh002.update()
        svh003.update()
        svh004.update()
        
        svo101.update()
        svo102.update()
        ebvo102.update()
        bvo101.update()

        svf201.update()
        pbvf201.update()
        svf204.update()
        cpf201.update()

        svh001_state.update()
        svh002_state.update()
        svh003_state.update()
        svh004_state.update()
        
        svo101_state.update()
        svo102_state.update()
        ebvo102_state.update()
        bvo101_state.update()

        svf201_state.update()
        pbvf201_state.update()
        svf204_state.update()
        cpf201_state.update()
        prh001.update()
        prh002.update()
        prh001_open.open_percentage()
        prh002_open.open_percentage()

    }
    function messagesBox(){
        //print("Test", bridge.serverStatus)
        if (bridge.getServerStatus()){
            server_status_text.color = "#32CD32"
            server_status_text.text= qsTr("CONNECTED")
        }else{
            server_status_text.color = "#FF0000"
            server_status_text.text= qsTr("NOT CONNECTED")
        }

        }

    Rectangle {
        width: 2560
        height: 1440
        color: "#000000"
        transformOrigin: Item.TopLeft
        scale: dpi_scale

        Rectangle {
            id: rectangle1
            x: 28
            y: 21
            width: 1970
            height: 979
            color: "#00ffffff"
            border.color: "#ffffff"

            Image {
                id: pid
                y: 72
                width: 1902
                height: 833
                anchors.left: parent.left
                source: "content/Images/pidUpdated.png"
                anchors.leftMargin: 34
                fillMode: Image.PreserveAspectFit

                Gage {
                    id: pth001
                    name: "PTH001"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 289
                    anchors.leftMargin: 219
                }

                Gage {
                    id: tco103
                    name: "TCO103"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1070
                    anchors.bottomMargin: 0
                }

                Gage {
                    id: pth002
                    name: "PTH002"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 219
                    anchors.bottomMargin: 259
                    
                }

                Gage {
                    id: tch001
                    name: "TCH001"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 219
                    anchors.bottomMargin: 229
                }

                Gage {
                    id: pth003
                    name: "PTH003"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 536
                    anchors.bottomMargin: 639
                }

                Gage {
                    id: pth004
                    name: "PTH004"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 536
                    anchors.bottomMargin: 579
                }

                Gage {
                    id: tch002
                    name: "TCH002"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 536
                    anchors.bottomMargin: 609
                }

                ValveState {
                    id: svh001_state
                    name: "SVH001"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 440
                    anchors.bottomMargin: 267
                }

                ValveState {
                    id: svh003_state
                    name: "SVH003"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 660
                    anchors.bottomMargin: 173
                }

                ValveState {
                    id: svo102_state
                    name: "SVO102"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 828
                    anchors.bottomMargin: 173
                }

                ValveState {
                    id: bvo101_state
                    name: "BVO101"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1289
                    anchors.bottomMargin: 0
                }

                ValveState {
                    id: ebvo102_state
                    name: "EBVO102" 
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1289
                    anchors.bottomMargin: 178
                }

                ValveState {
                    id: svo101_state
                    name: "SVO101"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1158
                    anchors.bottomMargin: 178
                }

                ValveState {
                    id: pbvf201_state
                    name: "PBVF201"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1289
                    anchors.bottomMargin: 496
                }

                ValveState {
                    id: svf204_state
                    name: "SVF204"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1289
                    anchors.bottomMargin: 640
                }

                ValveState {
                    id: cpf201_state
                    name: "CPF201"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1208
                    anchors.bottomMargin: 768
                }

                ValveState {
                    id: svf201_state
                    name: "SVF201"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 827
                    anchors.bottomMargin: 496
                }

                ValveState {
                    id: svh004_state
                    name: "SVH004"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 660
                    anchors.bottomMargin: 496
                }

                ValveState {
                    id: svh002_state
                    name: "SVH002"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 402
                    anchors.bottomMargin: 418
                }

                Reg {
                    id: prh001
                    name: "PRH001"
                    state: "NOTARMED"
                    x: 571
                    y: 315
                    anchors.bottomMargin: 434
                    anchors.leftMargin: 571
                }
                
                Reg {
                    id: prh002
                    name: "PRH002"
                    state: "NOTARMED"
                    x: 571
                    y: 502
                }

                LoxValve {
                    id: svo101
                    name: "SVO101"
                    state: "CD"
                    width: 77
                    height: 44
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1170
                    anchors.bottomMargin: 251
                    
                }

                FuelBallValve {
                    id: pbvf201
                    name: "PBVF201"
                    width: 85
                    height: 41
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1295
                    anchors.bottomMargin: 432
                }

                FuelCompressor {
                    id: cpf201
                    name: "CPF201"
                    width: 67
                    height: 44
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1216
                    anchors.bottomMargin: 718
                }

                Rectangle {
                    id: lox_percentage
                    width: 63
                    height: 22
                    color: "#000000"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1024
                    anchors.bottomMargin: 231
                }

                TankLevel {
                    id: dpf201
                    name: "DPF201"
                    width: 63
                    height: 22
                    y: 393
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1024
                    anchors.bottomMargin: 418
                }

                LoxBallValve {
                    id: ebvo102
                    name: "EBVO102"
                    width: 85
                    height: 41
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1295
                    anchors.bottomMargin: 251
                }

                LoxBallValve {
                    id: bvo101
                    name: "BVO101"
                    width: 85
                    height: 41
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1295
                    anchors.bottomMargin: 92
                }

                HeliumValve {
                    id: svh004
                    name: "SVH004"
                    width: 77
                    height: 44
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 670
                    anchors.bottomMargin: 436
                }

                HeliumValve {
                    id: svh003
                    name: "SVH003"
                    width: 77
                    height: 44
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 670
                    anchors.bottomMargin: 251
                }

                HeliumValve {
                    id: svh001
                    name: "SVH001"
                    x: 445
                    y: 455
                    width: 77
                    height: 44
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 335
                    anchors.leftMargin: 445
                }

                HeliumValve {
                    id: svh002
                    name: "SVH002"
                    width: 77
                    height: 44
                    ang_Open: 90
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 330
                    anchors.bottomMargin: 420
                }

                HeliumValve {
                    id: svf201
                    name: "SVF201"
                    width: 77
                    height: 44
                    ang_Open: 90
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 760
                    anchors.bottomMargin: 498
                }

                HeliumValve {
                    id: svo102
                    name: "SVO102"
                    width: 77
                    height: 44
                    state: "CD"
                    ang_Open: 90
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 760
                    anchors.bottomMargin: 178
                }

                FuelValve {
                    id: svf204
                    name: "SVF204"
                    x: 1295
                    y: 199
                    width: 77
                    height: 44
                    state: "CD"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1295
                    anchors.bottomMargin: 590
                }
                Gage {
                    id: ptf401
                    name: "PTF401"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1657
                    anchors.bottomMargin: 579
                    
                }

                Gage {
                    id: ptf402
                    name: "PTF402"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1657
                    anchors.bottomMargin: 549
                }

                Gage {
                    id: tcf401
                    name: "TCF401"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1657
                    anchors.bottomMargin: 519
                }

                Gage {
                    id: tcf402
                    name: "TCF402"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 1657
                    anchors.bottomMargin: 490
                }

                Gage {
                    id: pth005
                    name: "PTH005"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 551
                    anchors.bottomMargin: 110
                }

                Gage {
                    id: pth006
                    name: "PTH006"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 551
                    anchors.bottomMargin: 80
                }

                Gage {
                    id: tch003
                    name: "TCH003"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 551
                    anchors.bottomMargin: 51
                }

                Gage {
                    id: pto101
                    name: "PTO101"
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 898
                    anchors.bottomMargin: 110
                }

                Gage {
                    id: tco101
                    name: "TCO101"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 898
                    anchors.bottomMargin: 80
                }

                Gage {
                    id: tco102
                    name: "TCO102"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 898
                    anchors.bottomMargin: 51
                }

                Gage {
                    id: pto102
                    name: "PTO102"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 291
                    anchors.bottomMargin: 208
                }

                Gage {
                    id: pto103
                    name: "PTO103"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 291
                    anchors.bottomMargin: 178
                }

                Gage {
                    id: tco104
                    name: "TCO104"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 291
                    anchors.bottomMargin: 148
                }

                Gage {
                    id: ptf203
                    name: "PTF203"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 293
                    anchors.bottomMargin: 549
                }

                Gage {
                    id: ptf204
                    name: "PTF204"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 293
                    anchors.bottomMargin: 519
                }

                Gage {
                    id: tcf203
                    name: "TCF203"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 293
                    anchors.bottomMargin: 489
                }

                Gage {
                    id: ptf403
                    name: "PTF403"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 71
                    anchors.bottomMargin: 208
                }

                Gage {
                    id: tcf403
                    name: "TCF403"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 71
                    anchors.bottomMargin: 178
                }

                Gage {
                    id: pto404
                    name: "PTO404"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 71
                    anchors.bottomMargin: 148
                }

                Gage {
                    id: tco404
                    name: "TCO404"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 71
                    anchors.bottomMargin: 119
                }

                Gage {
                    id: ptc405
                    name: "PTC405"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 17
                    anchors.bottomMargin: 286
                }

                Gage {
                    id: ptc406
                    name: "PTC406"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 17
                    anchors.bottomMargin: 256
                }

                Gage {
                    id: ptf201
                    name: "PTF201"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 836
                    anchors.bottomMargin: 646
                }

                Gage {
                    id: ptf202
                    name: "PTF202"
                    width: 180
                    height: 30
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 836
                    anchors.bottomMargin: 617
                }

                Gage {
                    id: tcf201
                    name: "TCF201"
                    width: 180
                    height: 30
                    unit: "K"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 836
                    anchors.bottomMargin: 587
                }
            }

            Image {
                id: logowhite
                x: 33
                y: 23
                width: 220
                height: 109
                source: "content/Images/logo white.png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: text1
                x: 270
                y: 55
                color: "#ffffff"
                text: qsTr("MISSION CONTORL")
                font.pixelSize: 38
            }

            Rectangle {
                id: rectangle
                x: 1990
                y: 0
                width: 521
                height: 1357
                color: "#00ffffff"
                border.color: "#ffffff"
                anchors.right: parent.right
                anchors.rightMargin: -541

                Rectangle {
                    id: rectangle2
                    y: 0
                    height: 45
                    color: "#530b1d"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0

                    TextEdit {
                        id: textEdit
                        y: 7
                        width: 180
                        height: 31
                        color: "#ffffff"
                        text: qsTr("VALVES")
                        font.pixelSize: 23
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: rectangle3
                    y: 772
                    height: 45
                    color: "#1a3f0f"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0

                    TextEdit {
                        id: textEdit1
                        y: 7
                        width: 233
                        height: 30
                        color: "#ffffff"
                        text: qsTr("IGNITION SEQUENCE")
                        font.pixelSize: 23
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    GridLayout {
                        columns: 3
                        columnSpacing: 0
                        rowSpacing: 0
                        Layout.columnSpan: 10
                        anchors.top: rectangle3.bottom
                        anchors.topMargin: -2
                        anchors.left: rectangle3.left
                        width: 521
                        height: 163

                        Rectangle {
                                id: rectangle5
                                height: 41
                                width:174
                                color: "#00ffffff"
                                border.color: "#ffffff"
                                Text {
                                    id: text6
                                    color: "#ffffff"
                                    text: qsTr("TIMER")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 25
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                        Rectangle {
                                id: rectangle6
                                width: 174
                                height: 41
                                color: "#000000"
                                border.color: "#ffffff"

                                TextField {
                                    id: textField
                                    opacity: 1
                                    visible: true
                                    color: "#26bd2e"
                                    text: "30"
                                    readOnly: false
                                    anchors.fill: parent
                                    font.pixelSize: 25
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    hoverEnabled: false
                                    anchors.rightMargin: 0
                                    anchors.bottomMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.topMargin: 0
                                    placeholderTextColor: "#00ffffff"
                                    placeholderText: qsTr("Text Field")
                                        background:Rectangle{
                                            color: "#000000"
                                            border.color: "#FFFFFF"
                                        }
                                    

                                }
                         }

                        Rectangle {
                                id: rectangle7
                                width: 174
                                height: 41
                                color: "#00ffffff"
                                border.color: "#ffffff"
                                Text {
                                    id: text7
                                    color: "#65e5e7"
                                    text: qsTr("s")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 22
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                         }
                         
                        Rectangle {
                                id: rectangle8
                                height: 41
                                width:174

                                color: "#00ffffff"
                                border.color: "#ffffff"
                                Text {
                                    id: text8
                                    color: "#ffffff"
                                    text: qsTr("PBVF201")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 25
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                         }

                        Rectangle {
                                id: rectangle9
                                width: 174
                                height: 41
                                color: "#000000"
                                border.color: "#ffffff"
                                TextField {
                                        id: textField2
                                        opacity: 1
                                        visible: true
                                        color: "#26bd2e"
                                        readOnly: false
                                        text: "30"
                                        anchors.fill: parent
                                        font.pixelSize: 25
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        hoverEnabled: false
                                        anchors.rightMargin: 0
                                        anchors.bottomMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                        placeholderTextColor: "#00ffffff"
                                        placeholderText: qsTr("Text Field")
                                        background:Rectangle{
                                            color: "#000000"
                                            border.color: "#FFFFFF"
                                        }

                                    }
                            }

                        Rectangle {
                                id: rectangle11
                                width: 174
                                height: 41
                                color: "#00ffffff"
                                border.color: "#ffffff"
                                Text {
                                        id: text9
                                        color: "#65e5e7"
                                        text: qsTr("ms")
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.pixelSize: 22
                                        horizontalAlignment: Text.AlignLeft
                                        anchors.horizontalCenter: parent.horizontalCenter
                                 }
                         }
                             
                        Rectangle {
                                id: rectangle12
                                height: 41
                                width:174

                                color: "#00ffffff"
                                border.color: "#ffffff"
                                Text {
                                    id: text10
                                    color: "#ffffff"
                                    text: qsTr("EBVO102")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 25
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                        }

                        Rectangle {
                                    id: rectangle13
                                    width: 174
                                    height: 41
                                    color: "#000000"
                                    border.color: "#ffffff"

                                    TextField {
                                        id: textField3
                                        opacity: 1
                                        visible: true
                                        color: "#26bd2e"
                                        readOnly: false
                                        text: "30"
                                        anchors.fill: parent
                                        font.pixelSize: 25
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        hoverEnabled: false
                                        anchors.rightMargin: 0
                                        anchors.bottomMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                        placeholderTextColor: "#00ffffff"
                                        placeholderText: qsTr("Text Field")
                                        background:Rectangle{
                                            color: "#000000"
                                            border.color: "#FFFFFF"
                                        }

                                    }
                         }

                        Rectangle {
                                    id: rectangle14
                                    width: 174
                                    height: 41
                                    color: "#00ffffff"
                                    border.color: "#ffffff"
                                    Text {
                                        id: text11
                                        color: "#65e5e7"
                                        text: qsTr("ms")
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.pixelSize: 22
                                        horizontalAlignment: Text.AlignLeft
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                
                            }
                         
                        Rectangle {
                                id: rectangle15
                                height: 41
                                width: 174
                                color: "#00ffffff"
                                border.color: "#ffffff"

                                Text {
                                    id: text12
                                    color: "#ffffff"
                                    text: qsTr("IGNITER")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 25
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                        }

                        Rectangle {
                                    id: rectangle16
                                    width: 174
                                    height: 41
                                    color: "#000000"
                                    border.color: "#ffffff"

                                    TextField {
                                        id: textField4
                                        opacity: 1
                                        visible: true
                                        color: "#26bd2e"
                                        text: "30"
                                        readOnly: false
                                        anchors.fill: parent
                                        font.pixelSize: 25
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        hoverEnabled: false
                                        anchors.rightMargin: 0
                                        anchors.bottomMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                        placeholderTextColor: "#00ffffff"
                                        placeholderText: qsTr("Text Field")
                                        background:Rectangle{
                                            color: "#000000"
                                            border.color: "#FFFFFF"
                                        }
                                       
                                    }
                         }

                        Rectangle {
                                id: rectangle17
                                width: 174
                                height: 41
                                color: "#00ffffff"
                                border.color: "#ffffff"

                                Text {
                                    id: text13
                                    color: "#65e5e7"
                                    text: qsTr("ms")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 22
                                    horizontalAlignment: Text.AlignLeft
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                
                         }
                     }

                    
                 Button {
                        id: send_button
                        y: 230
                        text: "SEND TIMING"
                        height: 76  
                        anchors.left: rectangle3.left
                        anchors.leftMargin: 33
                        anchors.right: rectangle3.right
                        anchors.rightMargin: 33
                                    
                        contentItem: Text {
                                        text: send_button.text
                                        font.pointSize: 30
                                        font.bold: true
                                        opacity: enabled ? 1.0 : 0.3
                                        color: "#ffffff"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                        background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 40
                                        opacity: enabled ? 1 : 0.3
                                        color: send_button.down ? "#732727" : "#696969"
                                        border.color: "#ffffff"
                                        border.width: 1
                                        radius: 4
                                    }
                                   
                        } 
                        Button {
                        id: abort_button
                        y: 400
                        text: "ABORT"
                        height: 100  
                        anchors.left: rectangle3.left
                        anchors.leftMargin: 33
                        anchors.right: rectangle3.right
                        anchors.rightMargin: 33
                                    
                        contentItem: Text {
                                        text: abort_button.text
                                        font.pointSize: 30
                                        font.bold: true
                                        opacity: enabled ? 1.0 : 0.3
                                        color: "#ffffff"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                        background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 40
                                        opacity: enabled ? 1 : 0.3
                                        color: abort_button.down ? "#732727" : "#FF0000"
                                        border.color: "#ffffff"
                                        border.width: 1
                                        radius: 4
                                    }
                            onClicked: {
                            }
                                   
                        }   

                                                                    
                                
                    }

                

                ValveToggle {
                    id: svh001t
                    name: "SVH001"
                    y: 96
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svh002t
                    name: "SVH002"
                    x: 280
                    y: 96
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svh003t
                    name: "SVH003"
                    y: 173
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svh004t
                    name: "SVH004"
                    x: 246
                    y: 173
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svo101t
                    name: "SVO101"
                    y: 292
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svo102t
                    name: "SVO102"
                    x: 246
                    y: 292
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: ebvo102t 
                    name: "EBVO102"
                    y: 369
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: bvo101t 
                    name: "BVO101"
                    x: 246
                    y: 369
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svf201t 
                    name: "SVF201"
                    y: 480
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: pbvf201t 
                    name: "PBVF201"
                    x: 246
                    y: 480
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svf204t     
                    name: "SVF204"
                    y: 557
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: cpf201t 
                    name: "CPF201"
                    x: 246
                    y: 557
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                Button {
                    id: close_button
                    text: "ACTUATE"
                    y: 645
                    height: 76
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    contentItem: Text {
                        text: close_button.text
                        font.pointSize: 30
                        font.bold: true
                        opacity: enabled ? 1.0 : 0.3
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: close_button.down ? "#865006" : "#b7500a"
                        border.color: "#ffffff"
                        border.width: 1
                        radius: 4
                        }       
                    onClicked: {
                            bridge.sendCommand()
                    }
                }
            
                
                Section_Header {
                    id: helium_label
                    hederText: "HELIUM"
                    y: 49
                    height: 43
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }

                Section_Header {
                    id: oxygen_label
                    hederText: "OXYGEN"
                    y: 244
                    height: 43
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }

                Section_Header {
                    id: kerosene_label
                    hederText: "KEROSENE"
                    y: 435
                    height: 43
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }
            }
            Rectangle {
                id: rectangle4
                x: 1385
                y: 978
                width: 585
                height: 379
                color: "#000000"
                border.color: "#ffffff"

                Rectangle {
                    id: rectangle18
                    height: 45
                    color: "#0a3a7f"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    
                    Text {
                        id: text20
                        width: 248
                        height: 29
                        color: "#ffffff"
                        text: qsTr("PRESSURE REGULATORS")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 23
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            RegToggle {
                id: prh001_toggle
                name: "PRH001"
                y: 81
                width: 208
                height: 65
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.leftMargin: 33
            }

            RegToggle {
                id: prh002_toggle
                name: "PRH002"
                x: 344
                y: 81
                width: 208
                height: 65
                color: "#00ffffff"
                anchors.right: parent.right
                anchors.rightMargin: 33
            }

            Image {
                id: upArrow
                x: 186
                y: 162
                width: 55
                height: 48
                source: "content/Images/UpArrow.png"
                fillMode: Image.PreserveAspectFit
                
                MouseArea { anchors.fill: parent; onClicked: bridge.regCommand("PRH001","increase") }
            }

            Image {
                id: downArrow
                x: 186
                y: 245
                width: 55
                height: 50
                source: "content/Images/DownArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent; onClicked: bridge.regCommand("PRH001","decrease") }
            }

            Image {
                id: upArrow1
                x: 497
                y: 162
                width: 55
                height: 48
                source: "content/Images/UpArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent; onClicked: bridge.regCommand("PRH002","increase") }
            }


            Image {
                id: downArrow1
                x: 497
                y: 245
                width: 55
                height: 50
                source: "content/Images/DownArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent; onClicked: bridge.regCommand("PRH002","decrease") }

            }

            Rectangle {
                id: prh001_open
                y: 197
                width: 132
                height: 51
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.leftMargin: 33
                border.color: "#ffffff"
                Text{
                    id: prh001_text
                    width: 74
                    color: "#ffffff"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                    rightPadding: 6
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 50
                    anchors.topMargin:5

                }
                Text{
                    id: percent_symbol
                    width: 74
                    color: "#ffffff"
                    font.pixelSize: 30
                    text: "%"      
                    rightPadding: 6
                    anchors.left: parent.left
                    anchors.leftMargin: 100
                    anchors.top: parent.top
                    anchors.topMargin:5
                }

                function open_percentage() {
                    prh001_text.text=qsTr(bridge.regState("PRH001"))
                }
            }

            Rectangle {
                id: prh002_open
                y: 197
                width: 132
                height: 51
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.leftMargin: 344
                border.color: "#ffffff"
                Text{
                    id: prh002_text
                    width: 74
                    color: "#ffffff"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                    rightPadding: 6
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 50
                    anchors.topMargin:5

                }
                Text{
                    id: percent_symbol2
                    width: 74
                    color: "#ffffff"
                    font.pixelSize: 30
                    text: "%"      
                    rightPadding: 6
                    anchors.left: parent.left
                    anchors.leftMargin: 100
                    anchors.top: parent.top
                    anchors.topMargin:5
                }

                function open_percentage() {
                    prh002_text.text=qsTr(bridge.regState("PRH002"))
                }

               }
             }
        }
        
        Button{
            id: kill_server
            x: 36
            y: 1351
            width: 237
            height: 58
            text: "KILL SERVER"
            contentItem: Text {
                        text: kill_server.text
                        font.pointSize: 30
                        font.bold: true
                        opacity: enabled ? 1.0 : 0.3
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
            background:Rectangle{
                border.color: "#ffffff"
                color: kill_server.down ? "#732727" : "#941010"
            }
            onClicked: {
                textField5.visible = true;
            }
            TextField {
                id: textField5
                x: 300
                y: 0
                width: 220
                height: 47
                font.pixelSize: 30
                echoMode: TextInput.Password 
                visible: false
                placeholderText: qsTr("Password")

                Keys.onReturnPressed:{
                    bridge.closeServer(textField5.text)
                    warning_text1.text= qsTr(bridge.getStatusMessages())
                }
             }
        }
        
        TextArea {
            id: textArea
            x: 38
            y: 1026
            width: 1067
            height: 300
            readOnly: true
            leftPadding: 20
            topPadding: 10
            font.pointSize: 30
            color: "#ffffff"
            placeholderText: qsTr("Text Area")
                    Text {
                    id: server_status_text
                    x: 23
                    y: 21
                    width: 1028
                    height: 44
                    color: "#ffffff"
                    text: qsTr("NOT CONNECTED")
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                }
                    Text {
                    id: warning_text1
                    x: 24
                    y: 71
                    width: 1028
                    height: 78
                    color: "#ffffff"
                    text: qsTr(" ")
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                }
            background:Rectangle{
                color: "#000000"
                border.color: "#FFFFFF"
            }
        }
            TextArea {
            id: textArea1
            x: 1557
            y: 35
            width: 424
            height: 107
            color: "#FFFFFF"
            font.pointSize: 50
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("T-30")
            placeholderText: qsTr("T-30")
            topPadding: 10
            leftPadding: 20
            background:Rectangle{
                color: "#000000"
            }
        }
     }
}
