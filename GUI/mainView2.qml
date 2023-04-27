import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Basic



import "content/Images"
import "content/QML objects/Gage"
import "content/QML objects/Valve"
import "content/QML objects/visual elements"


ApplicationWindow {
    id: window
    width: 3840
    height: 21600
    visible: true

    property real dpi_scale: 0.5

    
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

        // Refresh Kerosene TCs
        tcf201.fetchNewVal()
        tcf202.fetchNewVal()
        tcf401.fetchNewVal()
        tcf402.fetchNewVal()
        tcf403.fetchNewVal()

        // Chamber PTs
        ptc405.fetchNewVal()
        ptc406.fetchNewVal()

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
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

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
            width: 2052
            height: 979
            color: "#00ffffff"
            border.color: "#ffffff"

            Image {
                        id: hodorPID
                        x: 0
                        y: -6
                        width: 2035
                        height: 977
                        source: "content/Images/HODORGUI.png"
                fillMode: Image.PreserveAspectFit

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 31
                    x: 208
                    y: 205

                    Gage {
                        id: ptn002
                        name: "PTN002"
                        x: 0
                        y: 0
                    }

                }
                
                Rectangle{

                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 455
                    y: 205
                    
                    Gage {
                        id: ptn003
                        name: "PTN003"
                        x: 0
                        y: 0
                    }

                    Gage {
                        id: tcn001
                        name: "TCN001"
                        x: 0
                        y: 32
                        unit: "°C"
                    }

                }
                
                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 900
                    y: 341
                    Gage {
                        id: ptf201
                        name: "PTF201"
                        x: 0
                        y: 0
                    }

                    Gage {
                        id: tcf201
                        name: "TCF201"
                        x: 0
                        y: 32
                        unit: "°C"
                    }


                }
                
                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 1630
                    y: 223
                    Gage {
                            id: ptf202
                            name: "PTF202"
                            x: 0
                            y: 0
                    }

                    Gage {
                            id: tcf202
                            name: "TCF202"
                            x: 0
                            y: 32
                            unit: "°C"
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 1848
                    y: 525


                            Gage {
                            id: ptc405
                            name: "PTC405"
                            x: 0
                            y: 0
                           }

                            Gage {
                            id: ptc406
                            name: "PTC406"
                            x: 0
                            y: 32
                        }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 1712
                    y: 659


                        Gage {
                        id: pto102
                        name: "PTO102"
                        x: 0
                        y: 0
                    }

                        Gage {
                        id: tco102
                        name: "TCO102"
                        x: 0
                        y: 32
                        unit: "°C"
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 900
                    y: 651

                        Gage {
                        id: pto101
                        name: "PTO101"
                        x: 0
                        y: 0
                    }

                        Gage {
                        id: tco101
                        name: "TCO101"
                        x: 0
                        y: 32
                        unit: "°C"
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 62
                    x: 450
                    y: 515

                        Gage {
                        id: ptn004
                        name: "PTN004"
                        x: 0
                        y: 0
                    }

                        Gage {
                        id: tcn002
                        name: "TCN002"
                        x: 0
                        y: 32
                        unit: "°C"
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 93
                    x: 1625
                    y: 392

                        Gage {
                        id: ptf403
                        name: "PTF403"
                        x: 0
                        y: 0
                    }
                

                        Gage {
                        id: tcf403
                        name: "TCF403"
                        x: 0
                        y: 32
                        unit: "°C"
                    }

                        Gage {
                        id: pto404
                        name: "PTO404"
                        x: 0
                        y: 64
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 124
                    x: 1850
                    y: 155

                        Gage {
                        id: ptf401
                        name: "PTF401"
                        x: 0
                        y: 0
                    }
                
                        Gage {
                        id: ptf402
                        name: "PTF402"
                        x: 0
                        y: 32
                    }

                        Gage {
                        id: tcf401
                        name: "TCF401"
                        x: 0
                        y: 64
                        unit: "°C"
                    }

                        Gage {
                        id: tcf402
                        name: "TCF402"
                        x: 0
                        y: 96
                        unit: "°C"
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 32
                    x: 220
                    y: 532


                        Gage {
                        id: ptn001
                        name: "PTN001"
                        x: 0
                        y: 0
                    }
                }

                Rectangle{
                    color: "#000000"
                    border.color: "#ffffff"
                    width: 180
                    height: 32
                    x: 1120
                    y: 785



                        Gage {
                        id: tco103
                        name: "TCO103"
                        x: 0
                        y: 0
                        unit: "°C"
                    }
                }

                ValveState {
                        id: svn004_state
                        name: "SVN004"
                        x: 685
                        y: 230
                        nrm_Opn: false
                }

                ValveState {
                        id: svf201_state
                        name: "SVF201"
                        x: 967
                        y: 125
                        nrm_Opn: true
                }

                ValveState {
                        id: pbvf201_state
                        name: "PBVF201"
                        x: 1385
                        y: 230
                        nrm_Opn: false
                }

                ValveState {
                        id: svf202_state
                        name:"SVF202"
                        x: 1370
                        y: 106
                        nrm_Opn: false
                }

                ValveState {
                        id: svn007_state
                        name: "SVN007"
                        x: 1660
                        y: 808
                        nrm_Opn: false
                }

                        ValveState {
                        id: ebvo102_state
                        name: "EBVO102"
                        x: 1383
                        y: 782
                        nrm_Opn: false
                }

                        ValveState {
                        id: ebvo101_state
                        name: "EBVO101"
                        x: 1386
                        y: 655
                        nrm_Opn: false
                }

                        ValveState {
                        id: svo102_state
                        name: "SVO102"
                        x: 968
                        y: 470
                        nrm_Opn: true
                }

                        ValveState {
                        id: svn005_state
                        name: "SVN005"
                        x: 602
                        y: 739
                        nrm_Opn: false
                }
                    
                        ValveState {
                        id: svn003_state
                        name: "SVN003"
                        x: 674
                        y: 543
                        nrm_Opn: false
                }

                        

                        ValveState {
                        id: svn006_state
                        name: "SVN006"
                        x: 608
                        y: 427
                        nrm_Opn: false
                }

                        ValveState {
                        id: svn008_state
                        name: "SVN008"
                        x: 1668
                        y: 73
                        nrm_Opn: false
                }


                        Reg {
                        id: prh001
                        name: "PRN003"
                        x: 425
                        y: 288
                }

                        NitrogenValve {
                        id: svn004
                        name: "SVN004"
                        x: 697
                        y: 306
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn006
                        name: "SVN006"
                        x: 617
                        y: 384
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn003
                        name: "SVN003"
                        x: 684
                        y: 615
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svn005
                        name: "SVN005"
                        x: 616
                        y: 696
                        width: 57
                        height: 36
                }

                        NitrogenValve {
                        id: svf201
                        name: "SVF201"
                        x: 980
                        y: 211
                        nrm_Opn: true
                }

                        NitrogenValve {
                        id: svo102
                        name: "SVO102"
                        x: 980
                        y: 542
                        nrm_Opn: true
                }

                        NitrogenValve {
                        id: svn007
                        name: "SVN007"
                        x: 1674
                        y: 752
                        width: 57
                        height: 36
                }

                        FuelBallValve {
                            id: pbvf201
                            name: "PBVF201"
                            x: 1396
                            y: 310
                }

                        LoxBallValve {
                            id: ebvo102
                            name: "EBVO102"
                            x: 1392
                            y: 738
                            width: 55
                            height: 28
                }

                        LoxBallValve {
                            id: ebvo101
                            name: "EBVO101"
                            x: 1396
                            y: 619
                            width: 61
                            height: 32
                }

                        NitrogenValve {
                        id: svn008
                        name: "SVN008"
                        x: 1683
                        y: 142
                        width: 57
                        height: 36
                }

                        FuelValve {
                        id: svf202
                        name: "SVF202"
                        x: 1382
                        y: 164
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
                    y: 920
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

                    MessageDialog {
                        id: messageDialog
                        title: "Warning"
                        text: "Initiate Ignition Sequence?"
                        buttons: MessageDialog.Ok | MessageDialog.Cancel
                        onAccepted: {
                            bridge.ignitionCmd(textField.text)
                        }
                        Component.onCompleted: visible = false
                    }
                    
                    Button {
                        id: ignition_button
                        y: 1260
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

                                messageDialog.visible = true

                                   
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
                        id: countdown_box
                        x: 932
                        width: 453
                        height: 241
                        color: "#000000"
                        border.color: "#ffffff"
                        anchors.top: rectangle1.bottom
                        anchors.topMargin: 0
                        anchors.right: parent.right
                        anchors.leftMargin: 0
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
                                readOnly: true
                                font.pixelSize: 80
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
               }
             }

             Rectangle {
                        id: load_cell_box
                        x: 932
                        width: 453
                        height: 241
                        color: "#000000"
                        border.color: "#ffffff"
                        anchors.top: rectangle1.bottom
                        anchors.topMargin: 0
                        anchors.right: countdown_box.left
                        anchors.leftMargin: 0
                        Rectangle {
                            id: rectangle55
                            height: 45
                            color: "#0a3a7f"
                            border.color: "#ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            Text {
                                id: text77
                                width: 248
                                height: 29
                                color: "#ffffff"
                                text: qsTr("LOAD CELL")
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0

                            LoadCell {
                                id: load_cell
                                x: 50
                                y: 77
                                name: "LC001"
                            }
                    
                         }

                 Button {
                    id: tare
                    text: "TARE LOAD CELL"
                    height: 40  
                    width: 200
                    anchors.top: parent.bottom
                    anchors.topMargin: -70
                    anchors.right: parent.right
                    anchors.rightMargin: 140

                    
                                                                
                    contentItem: Text {
                        text: tare.text
                        font.pointSize: 20
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
                        color: tare.down ? "#732727" : "#773301"
                        border.color: "#ffffff"
                        border.width: 1
                        radius: 4
                    }
                    
                    onClicked: {
                    }
                                                            
                 }   

             }
        }
        
        Button{
            id: kill_server
            x: 23
            width: 237
            height: 58
            text: "Close Server"
            anchors.top: rectangle1.bottom
            anchors.topMargin: 100
            contentItem: Text {
                        text: kill_server.text
                        font.pointSize: 25
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
                Qt.quit()
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

      
        
        Row{
            x: 23
            width: 2000
            height: 44
            padding: 5
            layoutDirection: Qt.LeftToRight
            anchors.top: rectangle1.bottom
            anchors.topMargin: 10

            Text{
                text: qsTr("SERVER STATUS: ")
                rightPadding: 0
                font.pixelSize: 30
                color: "#ffffff"
            }

            Text {
                    id: server_status_text
                    color: "#ffffff"
                    text: qsTr("NOT CONNECTED")
                    font.pixelSize: 30
                    leftPadding: 50
                    
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
                    x: 1650
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
