import telemetry
import time
import math

import serverThreads
import serverFunc

import sys

from PySide6 import QtWidgets, QtQuick
from PySide6.QtQml import QmlElement
from PySide6.QtCore import QObject, Slot, QTimer

QML_IMPORT_NAME = "GUI2"
QML_IMPORT_MAJOR_VERSION = 1
 
@QmlElement
class Bridge(QObject):
    
    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s
        self.armedValues = s.getArmedValves()
        self.guiReadings = s.getDataReadings()
        self.valveStates = s.getValveReadings()
        self.serverStatus = s.isConnected()
        self.statusMessages= "none"

        self.percent1=0
        self.percent2=0
        self.armFlag=0

    @Slot(result=bool)   
    def getServerStatus(self):
        return self.s.isConnected()

    #returns the value associated with the sensor
    @Slot(str, result=str)
    def updateGage(self, gageName):
        try:
            return self.guiReadings[gageName]

        except Exception as e:
            return "N/A"

    @Slot(str,str)#arming the valves to their default state
    def armValve(self, valveName:str, state:str):
        self.armedValues[valveName]=state
        print(valveName,":",state)
        if state == "ARMED":
            self.s.setArmedValve(valveName)

    @Slot(str, result=bool)
    def disArm(self,name:str):
        valveName = self.s.getArmedValve()
        #print(valveName)
        if name!=valveName:
            return True
        else:
            return False
        

    @Slot(str, result=bool)
    def getValveState(self, valveName:str):
        #return true if valve is open
        try:
            reading = self.valveStates[valveName]
            if reading == 'ON':
                return True
            else:
                return False

        except:
            #self.data.update(valveName,'OPENED_','000000')
            self.valveStates[valveName] = "OFF"
            return False

    
    @Slot(str, result=bool)
    def getArmState(self, valveName:str):
        #return true if valve is armed
        try:
            armed = self.armedValues[valveName]
            if armed == 'ARMED':
                return True
            else:
                return False

        except:
            return False
    @Slot(str,str, result=int)        
    def regCommand(self, name:str, direction:str):
        if name=="PRH001": 
            if direction == "increase":
                if self.armedValues[name]=="ARMED":
                    self.percent1+=1
                    percent=self.percent1
            else:
                if self.armedValues[name]=="ARMED":
                    self.percent1-=1
                    percent=self.percent1

        if name=="PRH002":
            if direction == "increase":
                if self.armedValues[name]=="ARMED":
                    self.percent2+=1
                    percent=self.percent2
            else:
                if self.armedValues[name]=="ARMED":
                    self.percent2-=1
                    percent=self.percent2
        
        print(name, "open percent: ", percent )
        return percent
    
    @Slot(str,result=str)        
    def regState(self,name):
        if name=="PRH001":
            return str(self.percent1)
        else:
            return str(self.percent2)
    @Slot()
    def sendCommand(self):
        valveName = self.s.getArmedValve()
        print(valveName)
        if valveName != "None":
            self.s.sendValveCmd(valveName)
    
    @Slot(str)
    def closeServer(self, password):
        if password == "kill":
            self.statusMessages="  "
            self.s.closeSocket()
        else:
            self.statusMessages= "incorrect password, try again"
    
    @Slot(result=str)
    def getStatusMessages(self):
        return self.statusMessages
    
    
        
        


def guiThreadFunc(s:serverFunc.Server):

    #newobject = myClass()

    bridge = Bridge(s)

    # bridge.guiReadings = inReadings
    # bridge.guiReadings = armedValues
    

    #print(newobject.myprop)

    app = QtWidgets.QApplication()
    view = QtQuick.QQuickView()

    timer = QTimer()
    timer.start(10)

    view.setSource("GUI/mainView2.qml")

    root = view.rootObject()

    context = view.rootContext()
    context.setContextProperty("bridge", bridge)

    timer.timeout.connect(root.updateElements)
    timer.timeout.connect(root.messagesBox)

    
    view.show()
    
    sys.exit(app.exec())
    

