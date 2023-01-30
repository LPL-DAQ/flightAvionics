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

#not sure what this does...
# class myClass():

#     myprop:int = 0

#     def someMeth(self):
#         #return math.sin(time.time())
#         self.myprop = self.myprop + 1
#         return self.myprop


 
@QmlElement
class Bridge(QObject):
    
    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s
        self.armedValues = s.getArmedValves()
        self.guiReadings = s.getDataReadings()
        self.valveStates = s.getValveReadings()


    # guiReadings: dataRead.Readings
    # armedValves = dict()
    # guiReadings = readings.Readings
    # armedValves = dict()

    # @Slot(result=str)
    # def uptext(self):
        
    #     #s = "{:0>7.0f}".format(time.time())
    #     s = "YODAYO! 1"

    #     return s
    
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

    @Slot(str, result=bool)
    def getValveState(self, valveName:str):
        #return true if valve is open
        try:
            reading = self.valveStates[valveName]
            if reading == 'OPENED_':
                return True
            else:
                return False

        except:
            #self.data.update(valveName,'OPENED_','000000')
            self.valveStates[valveName] = "OPENED_"
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

    @Slot()
    def sendCommand(self):
        serverThreads.appendCommand(self.valveStates, self.armedValues)
        


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

    view.setSource("GUI/mainView.qml")

    root = view.rootObject()

    context = view.rootContext()
    context.setContextProperty("bridge", bridge)

    timer.timeout.connect(root.updateElements)
    
    view.show()
    
    sys.exit(app.exec())
    

