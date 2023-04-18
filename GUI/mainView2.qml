import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts
import "content/Images"
import "content/QML objects/Gage"
import "content/QML objects/Valve"
import "content/QML objects/visual elements"



ApplicationWindow {
    id: window
    width: 3840
    height: 21600
    visible: true

    property real dpi_scale: 1.4

    function updateElements() {



        // Refresh Nitrogen PTs
        ptn001.fetchNewVal()
        ptn002.fetchNewVal()
        ptn003.fetchNewVal()
        ptn004.fetchNewVal()

        // Refresh LOx PTs
        pto101.fetchNewVal()
        pto102.fetchNewVal()
        pto404.fetchNewVal()

        // Refresh Kerosene PTs
        ptf201.fetchNewVal()
        ptf202.fetchNewVal()
        ptf401.fetchNewVal()
        ptf402.fetchNewVal()
        ptf403.fetchNewVal()
        
        // Refresh Helium TCs
        tcn001.fetchNewVal()
        tcn002.fetchNewVal()

        // Refresh LOX TCs
        tco101.fetchNewVal()
        tco102.fetchNewVal()
        tco103.fetchNewVal()
        tco404.fetchNewVal()

        // Refresh Kerosene TCs
        tcf201.fetchNewVal()
        tcf202.fetchNewVal()
        tcf401.fetchNewVal()
        tcf402.fetchNewVal()
        tcf403.fetchNewVal()

        // Chamber PTs
        ptc405.fetchNewVal()
        ptc406.fetchNewVal()

        // Tank Level
        dpf001.fetchNewVal()

        svn003t.update()
        svn004t.update()
        svn005t.update()
        svn006t.update()
        svn007t.update()
        svn008t.update()

        svo102t.update()
        ebvo102t.update()
        ebvo101t.update()

        svf201t.update()
        pbvf201t.update()
        svf202t.update()
        cpf201t.update()


        svn003.update()
        svn004.update()
        svn005.update()
        svn006.update()
        svn007.update()
        svn008.update()
        
        svo102.update()
        ebvo102.update()
        ebvo101.update()

        svf201.update()
        pbvf201.update()
        svf202.update()
        cpf201.update()

        svn003_state.update()
        svn004_state.update()
        svn005_state.update()
        svn006_state.update()
        svn007_state.update()
        svn008_state.update()

        
        svo102_state.update()
        ebvo102_state.update()
        ebvo101_state.update()

        svf201_state.update()
        pbvf201_state.update()
        svf202_state.update()
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

    ScrollView{
        anchors.fill: parent

        Flickable{
            contentWidth: 2560*dpi_scale
            contentHeight:  1440*dpi_scale
        
    
    Rectangle {
                width: maximumWidth
                height: maximumHeight
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
                        id: hodorPID
                        x: 0
                        y: 8
                        width: 1970
                        height: 971
                        source: "content/Images/HodorPID.png"
                fillMode: Image.PreserveAspectFit

                Gage {
                        id: ptn002
                        name: "PTN002"
                        x: 246
                        y: 249
                }

                Gage {
                        id: ptn003
                        name: "PTN003"
                        x: 473
                        y: 242
                }

                Gage {
                        id: tcn001
                        name: "TCN001"
                        x: 473
                        y: 274
                        unit: "°C"
                }

                Gage {
                        id: ptf201
                        name: "PTF201"
                        x: 885
                        y: 194
                }

                Gage {
                        id: tcf201
                        name: "TCF201"
                        x: 885
                        y: 225
                        unit: "°C"
                }

                Gage {
                        id: ptf202
                        name: "PTF202"
                        x: 1555
                        y: 279
                }

                Gage {
                        id: tcf202
                        name: "TCF202"
                        x: 1555
                        y: 310
                        unit: "°C"
                }

                        Gage {
                        id: ptc405
                        name: "PTC405"
                        x: 1761
                        y: 607
                }

                        Gage {
                        id: ptc406
                        name: "PTC406"
                        x: 1761
                        y: 639
                }

                        Gage {
                        id: pto102
                        name: "PTO102"
                        x: 1585
                        y: 693
                }

                        Gage {
                        id: tco102
                        name: "TCO102"
                        x: 1585
                        y: 724
                        unit: "°C"
                }

                        Gage {
                        id: pto101
                        name: "PTO101"
                        x: 884
                        y: 485
                }

                        Gage {
                        id: tco101
                        name: "TCO101"
                        x: 884
                        y: 516
                        unit: "°C"
                }

                        Gage {
                        id: ptn004
                        name: "PTN004"
                        x: 466
                        y: 538
                }

                        Gage {
                        id: tcn002
                        name: "TCN002"
                        x: 466
                        y: 568
                        unit: "°C"
                }

                        Gage {
                        id: ptf403
                        name: "PTF403"
                        x: 1488
                        y: 424
                }

                        Gage {
                        id: tcf403
                        name: "TCF403"
                        x: 1488
                        y: 454
                        unit: "°C"
                }

                        Gage {
                        id: pto404
                        name: "PTO404"
                        x: 1488
                        y: 484
                }

                        Gage {
                        id: tco404
                        name: "TCO404"
                        x: 1488
                        y: 514
                        unit: "°C"
                }

                        Gage {
                        id: ptf401
                        name: "PTF401"
                        x: 1775
                        y: 205
                }
                
                        Gage {
                        id: ptf402
                        name: "PTF402"
                        x: 1775
                        y: 236
                }

                        Gage {
                        id: tcf401
                        name: "TCF401"
                        x: 1775
                        y: 267
                        unit: "°C"
                }

                        Gage {
                        id: tcf402
                        name: "TCF402"
                        x: 1775
                        y: 298
                        unit: "°C"
                }

                        Gage {
                        id: ptn001
                        name: "PTN001"
                        x: 246
                        y: 540
                }

                        Gage {
                        id: tco103
                        name: "TCO103"
                        x: 1222
                        y: 762
                        unit: "°C"
                }

                        ValveState {
                        id: svn004_state
                        name: "SVN004"
                        x: 670
                        y: 275
                        nrm_Opn: false
                }

                TankLevel {
                    id: dpf001
                    name: "DPF001"
                    width: 63
                    height: 22
                    y: 420
                    anchors.left: parent.left
                    anchors.leftMargin: 1024

                }
                        ValveState {
                        id: svf201_state
                        name: "SVF201"
                        x: 865
                        y: 275
                        nrm_Opn: true
                }

                        ValveState {
                        id: pbvf201_state
                        name: "PBVF201"
                        x: 1265
                        y: 275
                        nrm_Opn: false
                }

                        ValveState {
                        id: svf202_state
                        name:"SVF202"
                        x: 1250
                        y: 150
                        nrm_Opn: false
                }

                        ValveState {
                        id: cpf201_state
                        name: "CPF201"
                        x: 1180
                        y: 40
                        nrm_Opn: false
                }

                        ValveState {
                        id: svn007_state
                        name: "SVN007"
                        x: 1470
                        y: 732
                        nrm_Opn: false
                }

                        ValveState {
                        id: ebvo102_state
                        name: "EBVO102"
                        x: 1265
                        y: 680
                        nrm_Opn: false
                }

                        ValveState {
                        id: ebvo101_state
                        name: "EBVO101"
                        x: 1032
                        y: 818
                        nrm_Opn: false
                }

                        ValveState {
                        id: svo102_state
                        name: "SVO102"
                        x: 882
                        y: 689
                        nrm_Opn: true
                }

                        ValveState {
                        id: svn005_state
                        name: "SVN005"
                        x: 670
                        y: 770
                        nrm_Opn: false
                }
                    
                        ValveState {
                        id: svn003_state
                        name: "SVN003"
                        x: 670
                        y: 569
                        nrm_Opn: false
                }

                        

                        ValveState {
                        id: svn006_state
                        name: "SVN006"
                        x: 670
                        y: 477
                        nrm_Opn: false
                }

                        ValveState {
                        id: svn008_state
                        name: "SVN008"
                        x: 1510
                        y: 198
                        nrm_Opn: false
                }


                        Reg {
                        id: prh001
                        name: "PRN003"
                        x: 471
                        y: 326
                }

                        Reg {
                        id: prh002
                        name: "PRN004"
                        x: 471
                        y: 619
                }

                        NitrogenValve {
                        id: svn004
                        name: "SVN004"
                        x: 680
                        y: 346
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn006
                        name: "SVN006"
                        x: 678
                        y: 433
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn003
                        name: "SVN003"
                        x: 681
                        y: 639
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn005
                        name: "SVN005"
                        x: 679
                        y: 726
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svf201
                        name: "SVF201"
                        ang_Open: 90
                        x: 811
                        y: 288
                        nrm_Opn: true
                }

                        NitrogenValve {
                        id: svo102
                        name: "SVO102"
                        ang_Open: 90
                        x: 828
                        y: 701
                        nrm_Opn: true
                }

                        NitrogenValve {
                        id: svn007
                        name: "SVN007"
                        ang_Open: 90
                        x: 1412
                        y: 746
                        width: 57
                        height: 36
                }

                        FuelCompressor {
                        id: cpf201
                        width: 51
                        height: 37
                        name: "CPF201"
                        x: 1197
                        y: 99
                }

                        FuelBallValve {
                            id: pbvf201
                            name: "PBVF201"
                            x: 1277
                            y: 350
                }

                        LoxBallValve {
                            id: ebvo102
                            name: "EBVO102"
                            x: 1277
                            y: 635
                            width: 55
                            height: 28
                }

                        LoxBallValve {
                            id: ebvo101
                            name: "EBVO101"
                            x: 1042
                            y: 758
                            width: 61
                            height: 32
                }

                        NitrogenValve {
                        id: svn008
                        name: "SVN008"
                        ang_Open: 90
                        x: 1451
                        y: 211
                        width: 57
                        height: 36
                }

                        FuelValve {
                        id: svf202
                        name: "SVF202"
                        x: 1263
                        y: 212
                }

                        Rectangle {
                        id: fuel_level
                        x: 1031
                        y: 380
                        width: 78
                        height: 24
                        color: "#000000"
                }

                        Rectangle {
                        id: lox_level
                        x: 1030
                        y: 670
                        width: 78
                        height: 24
                        color: "#000000"
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
                text: qsTr("MISSION CONTROL")
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
                            y: 943
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
                                    text: qsTr("IGNITER")
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
                                        text: "10"
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
                                        text: "20"
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
                                    text: qsTr("PBVF201")
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
                                        color: send_button.down ? "#732727" : "#808080"
                                        border.color: "#ffffff"
                                        border.width: 1
                                        radius: 4
                                    }
                            onClicked: {
                            ignition_button.visible = true;
                            bridge.sendTiming(textField.text, textField2.text, textField3.text, textField4.text)
                            }
                                   
                        } 
                                
                    }
                    Button {
                        id: ignition_button
                        y: 1150
                        text: "IGNITION"
                        height: 76  
                        visible: false
                        anchors.left: rectangle3.left
                        anchors.leftMargin: 33
                        anchors.right: rectangle3.right
                        anchors.rightMargin: 33
                        contentItem: Text {
                                        text: ignition_button.text
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
                                        color: ignition_button.down ? "#732727" : "#cb2a2a"
                                        border.color: "#ffffff"
                                        border.width: 1
                                        radius: 4
                                    }
                            onClicked: {
                                bridge.ignitionCmd(textField.text)
                            }
                    }

                

                ValveToggle {
                    id: svn004t
                    name: "SVN004"
                    y: 96
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svn003t
                    name: "SVN003"
                    x: 280
                    y: 96
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svn006t
                    name: "SVN006"
                    y: 175
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svn005t
                    name: "SVN005"
                    y: 175
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                     }

                ValveToggle {
                    id: svn008t
                    name: "SVN008"
                    y: 253
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                     }

                ValveToggle {
                    id: svn007t
                    name: "SVN007"
                    y: 253
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: svo102t
                    name: "SVO102"
                    y: 370
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: true
                }

                ValveToggle {
                    id: ebvo101t
                    name: "EBVO101"
                    x: 246
                    y: 370
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: ebvo102t 
                    name: "EBVO102"
                    y: 447
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: bvo101t 
                    name: "BVO101"
                    x: 246
                    y: 447
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                    visible: false
                }

                ValveToggle {
                    id: svf201t 
                    name: "SVF201"
                    y: 567
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: true
                }

                ValveToggle {
                    id: svf202t 
                    name: "SVF202"
                    x: 246
                    y: 567
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                            id: pbvf201t     
                            name: "PBVF201"
                            y: 644
                    anchors.left: parent.left
                    anchors.leftMargin: 33
                    nrml_Opn: false
                }

                ValveToggle {
                    id: cpf201t 
                    name: "CPF201"
                    x: 246
                            y: 644
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    nrml_Opn: false
                }

                Button {
                    id: close_button
                    text: "ACTUATE"
                            y: 748
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
                            id: nitrogen_label
                            hederText: "NITROGEN"
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
                            y: 321
                    height: 43
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }

                Section_Header {
                    id: kerosene_label
                    hederText: "KEROSENE"
                            y: 519
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
                name: "PRN003"
                y: 81
                width: 208
                height: 65
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.leftMargin: 33
            }

            RegToggle {
                id: prh002_toggle
                name: "PRN004"
                x: 344
                y: 81
                width: 208
                height: 65
                color: "#00ffffff"
                anchors.right: parent.right
                anchors.rightMargin: 33
            }

            Timer { id: timer }

            Image {
                id: upArrow
                x: 186
                y: 162
                width: 55
                height: 48
                source: "content/Images/UpArrow.png"
                fillMode: Image.PreserveAspectFit
                
                MouseArea { anchors.fill: parent; 
                    onClicked: {
                        bridge.regCommand("PRN003","increase")
                    }
                }
                
            }

            Image {
                id: downArrow
                x: 186
                y: 245
                width: 55
                height: 50
                source: "content/Images/DownArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent;
                    onClicked: {
                        bridge.regCommand("PRN003","decrease")
                    }
                 }
            }

            Button{
                id: stop_button
                y: 300
                width: 208
                height: 65
                anchors.left: parent.left
                anchors.leftMargin: 33
                text: "STOP"
            contentItem: Text {
                        text: stop_button.text
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
                color: stop_button.down ? "#732727" : "#941010"
            }
            onClicked: {

                bridge.regCommand("PRN003","STOP")
            }
            }

            Image {
                id: upArrow1
                x: 497
                y: 162
                width: 55
                height: 48
                source: "content/Images/UpArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent;
                    onClicked: {
                        bridge.regCommand("PRN004","increase")
                    }
                }
            }


            Image {
                id: downArrow1
                x: 497
                y: 245
                width: 55
                height: 50
                source: "content/Images/DownArrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea { anchors.fill: parent;
                    onClicked: {
                        bridge.regCommand("PRN004","decrease")
                    }
                 }

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

                     Rectangle {
                        id: countdown_box
                        x: 932
                        width: 453
                        height: 241
                        color: "#000000"
                        border.color: "#ffffff"
                        anchors.top: rectangle1.bottom
                        anchors.topMargin: 0
                        Rectangle {
                            id: rectangle130
                            height: 45
                            color: "#206e67"
                            border.color: "#ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            Text {
                                id: text110
                                width: 248
                                height: 29
                                color: "#ffffff"
                                text: qsTr("COUNTDOWN")
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignHCenter
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0

                            TextEdit {
                                id: textEdit200
                                x: 39
                                y: 77
                                width: 368
                                height: 129
                                color: "#ffffff"
                                text: qsTr("T-30")
                                font.pixelSize: 80
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
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
                    x: 28
                    width: 932
            height: 300
            readOnly: true
            leftPadding: 20
            topPadding: 10
            font.pointSize: 30
                    anchors.top: rectangle1.bottom
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
            visible: false
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

                Button {
                    id: abort_button
                    x: 980
                    y: 1270
                    text: "ABORT"
                    height: 95  
                    width: 400
                    
                                                                
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
                        implicitWidth: 200
                        implicitHeight: 95
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
        }
     }
}
