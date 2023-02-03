import QtQuick 6.2
import QtQuick.Controls 6.2
import "content/Images"
import "content/QML objects/Gage"
import "content/QML objects/Valve"
import "content/QML objects/visual elements"



Item {
    id: window
    width: 2560*dpi_scale
    height: 1440*dpi_scale
    visible: true
    property real dpi_scale: 0.5
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

    }
    function server_status(){
        if (bridge.serverStatus){
            text7.text= qsTr("CONNECTED")
        }else{
            text7.text= qsTr("NOT CONNECTED")
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
            height: 1281
            color: "#00ffffff"
            border.color: "#ffffff"

            Image {
                id: copyofPIDGUI2GUINoText
                y: 200
                width: 1902
                height: 833
                anchors.left: parent.left
                source: "content/Images/Copy of P&ID GUI 2 - GUI No Text.png"
                anchors.leftMargin: 27
                fillMode: Image.PreserveAspectFit

                Gage {
                    id: pth001
                    name: "PTH001"
                    y: 514
                    width: 180
                    height: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 219
                }

                Gage {
                    id: tco103
                    name: "TCO103"
                    x: 1070
                    y: 803
                    width: 180
                    height: 30
                    unit: "K"
                }

                Gage {
                    id: pth002
                    name: "PTH002"
                    x: 219
                    y: 544
                    width: 180
                    height: 30
                }

                Gage {
                    id: tch001
                    name: "TCH001"
                    x: 219
                    y: 574
                    width: 180
                    height: 30
                    unit: "K"
                }

                Gage {
                    id: pth003
                    name: "PTH003"
                    x: 536
                    y: 164
                    width: 180
                    height: 30
                }

                Gage {
                    id: pth004
                    name: "PTH004"
                    x: 536
                    y: 224
                    width: 180
                    height: 30
                }

                Gage {
                    id: tch002
                    name: "TCH002"
                    x: 536
                    y: 194
                    width: 180
                    height: 30
                    unit: "K"
                }

                ValveState {
                    id: svh001_state
                    name: "SVH001"
                    x: 440
                    y: 506
                }

                ValveState {
                    id: svh003_state
                    name: "SVH003"
                    x: 660
                    y: 594
                }

                ValveState {
                    id: svo102_state
                    name: "SVO102"
                    x: 828
                    y: 595
                }

                ValveState {
                    id: bvo101_state
                    name: "BVO101"
                    x: 1289
                    y: 768
                }

                ValveState {
                    id: ebvo102_state
                    name: "EBVO102"
                    x: 1289
                    y: 594
                }

                ValveState {
                    id: svo101_state
                    name: "SVO101"
                    x: 1158
                    y: 592
                }

                ValveState {
                    id: pbvf201_state
                    name: "PBVF201"
                    x: 1289
                    y: 275
                }

                ValveState {
                    id: svf204_state
                    name: "SVF204"
                    x: 1289
                    y: 130
                }

                ValveState {
                    id: cpf201_state
                    name: "CPF201"
                    x: 1208
                    y: 0
                }

                ValveState {
                    id: svf201_state
                    name: "SVF201"
                    x: 827
                    y: 275
                }

                ValveState {
                    id: svh004_state
                    name: "SVH004"
                    x: 660
                    y: 275
                }

                ValveState {
                    id: svh002_state
                    name: "SVH002"
                    x: 402
                    y: 353
                }

                LoxValve {
                    id: svo101
                    name: "SVO101"
                    x: 1170
                    y: 538
                    state: "CD"
                    width: 77
                    height: 44

                }

                FuelBallValve {
                    id: pbvf201
                    name: "PBVF201"
                    x: 1295
                    y: 360
                    width: 85
                    height: 41
                    state: "CD"
                }

                FuelCompressor {
                    id: cpf201
                    name: "CPF201"
                    x: 1216
                    y: 71
                    width: 67
                    height: 44
                    state: "CD"
                }

                Rectangle {
                    id: lox_percentage
                    x: 1024
                    y: 580
                    width: 63
                    height: 22
                    color: "#000000"
                }

                Rectangle {
                    id: fuel_percentage
                    x: 1024
                    y: 393
                    width: 63
                    height: 22
                    color: "#000000"
                }

                LoxBallValve {
                    id: ebvo102
                    name: "EBVO102"
                    x: 1295
                    y: 541
                    width: 85
                    height: 41
                    state: "CD"
                }

                LoxBallValve {
                    id: bvo101
                    name: "BVO101"
                    x: 1295
                    y: 700
                    width: 85
                    height: 41
                    state: "CD"
                }

                HeliumValve {
                    id: svh004
                    name: "SVH004"
                    x: 670
                    y: 353
                    width: 77
                    height: 44
                    state: "CD"
                }

                HeliumValve {
                    id: svh003
                    name: "SVH003"
                    x: 670
                    y: 538
                    width: 77
                    height: 44
                    state: "CD"
                }

                HeliumValve {
                    id: svh001
                    name: "SVH001"
                    x: 445
                    y: 455
                    width: 77
                    height: 44
                    state: "CD"
                }

                HeliumValve {
                    id: svh002
                    name: "SVH002"
                    x: 327
                    y: 362
                    width: 77
                    height: 44
                    ang_Open: 90
                    state: "CD"
                }

                HeliumValve {
                    id: svf201
                    name: "SVF201"
                    x: 760
                    y: 284
                    width: 77
                    height: 44
                    ang_Open: 90
                    state: "CD"
                }

                HeliumValve {
                    id: svo102
                    name: "SVO102"
                    x: 760
                    y: 611
                    width: 77
                    height: 44
                    state: "CD"
                    ang_Open: 90
                }

                FuelValve {
                    id: svf204
                    name: "SVF204"
                    x: 1295
                    y: 199
                    width: 77
                    height: 44
                    state: "CD"
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
                height: 1281
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
                        font.bold: true
                    }
                }

                Rectangle {
                    id: rectangle3
                    y: 744
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
                        font.bold: true
                    }
                }

                Gage {
                    id: ptf401
                    name: "PTF401"
                    x: -305
                    y: 423
                    width: 180
                    height: 30
                    
                }

                Gage {
                    id: ptf402
                    name: "PTF402"
                    x: -305
                    y: 453
                    width: 180
                    height: 30
                }

                Gage {
                    id: tcf401
                    name: "TCF401"
                    x: -305
                    y: 483
                    width: 180
                    height: 30
                    unit: "K"
                }

                Gage {
                    id: tcf402
                    name: "TCF402"
                    x: -305
                    y: 513
                    width: 180
                    height: 30
                    unit: "K"
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
                    text: "CLOSE"
                    highlighted : true
                    y: 645
                    width: 207
                    height: 76
                    anchors.left: parent.left
                    anchors.leftMargin: 33
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
                
                Button {
                    id: open_button
                    highlighted : true
                    x: 248
                    y: 645
                    width: 207
                    height: 76
                    text: "OPEN"
                    anchors.right: parent.right
                    anchors.rightMargin: 33
                    contentItem: Text {
                        text: open_button.text
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
                        color: open_button.down ? "#084531" : "#0c6b4d"
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

            Gage {
                id: pth005
                name: "PTH005"
                x: 577
                y: 893
                width: 180
                height: 30
            }

            Gage {
                id: pth006
                name: "PTH006"
                x: 577
                y: 923
                width: 180
                height: 30
            }

            Gage {
                id: tch003
                name: "TCH003"
                x: 577
                y: 952
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: pto101
                name: "PTO101"
                x: 924
                y: 893
                width: 180
                height: 30
            }

            Gage {
                id: tco101
                name: "TCO101"
                x: 924
                y: 923
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: tco102
                name: "TCO102"
                x: 924
                y: 952
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: pto102
                name: "PTO102"
                x: 1458
                y: 793
                width: 180
                height: 30
            }

            Gage {
                id: pto103
                name: "PTO103"
                x: 1458
                y: 823
                width: 180
                height: 30
            }

            Gage {
                id: tco104
                name: "TCO104"
                x: 1458
                y: 853
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: ptf203
                name: "PTF203"
                x: 1458
                y: 453
                width: 180
                height: 30
            }

            Gage {
                id: ptf204
                name: "PTF204"
                x: 1458
                y: 483
                width: 180
                height: 30
            }

            Gage {
                id: tcf203
                name: "TCF203"
                x: 1458
                y: 513
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: ptf403
                name: "PTF403"
                x: 1678
                y: 793
                width: 180
                height: 30
            }

            Gage {
                id: tcf403
                name: "TCF403"
                x: 1678
                y: 823
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: pto404
                name: "PTO404"
                x: 1678
                y: 853
                width: 180
                height: 30
            }

            Gage {
                id: tco404
                name: "TCO404"
                x: 1678
                y: 882
                width: 180
                height: 30
                unit: "K"
            }

            Gage {
                id: ptc405
                name: "PTC405"
                x: 1732
                y: 716
                width: 180
                height: 30
            }

            Gage {
                id: ptc406
                name: "PTC406"
                x: 1732
                y: 746
                width: 180
                height: 30
            }

            Gage {
                id: ptf201
                name: "PTF201"
                x: 914
                y: 356
                width: 180
                height: 30
            }

            Gage {
                id: ptf202
                name: "PTF202"
                x: 914
                y: 385
                width: 180
                height: 30
            }

            Gage {
                id: tcf201
                name: "TCF201"
                x: 914
                y: 415
                width: 180
                height: 30
                unit: "K"
            }
        }
        Text {
            id: text6
            x: 49
            y: 1214
            width: 250
            height: 46
            color: "#ffffff"
            text: qsTr("SERVER STATUS: ")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        
        Text {
            id: text7
            x: 305
            y: 1214
            width: 250
            height: 46
            color: "#ff0000"
            text: qsTr("NOT CONNECTED")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
     }
}
