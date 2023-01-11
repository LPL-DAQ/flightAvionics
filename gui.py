import telemetry
import time
import math


import sys

from PySide6 import QtWidgets, QtQuick
from PySide6.QtQml import QmlElement
from PySide6.QtCore import QObject, Slot, QTimer

QML_IMPORT_NAME = "GUI2"
QML_IMPORT_MAJOR_VERSION = 1

class myClass():

    myprop:int = 0

    def someMeth(self):
        #return math.sin(time.time())
        self.myprop = self.myprop + 1
        return self.myprop


 
@QmlElement
class Bridge(QObject):
    
    guiReadings: telemetry.Readings
    armedValves = telemetry.armedValves

    @Slot(result=str)
    def uptext(self):
        
        #s = "{:0>7.0f}".format(time.time())
        s = "YODAYO! 1"

        return s

    @Slot(str, result=str)
    def updateGage(self, gageName):
        try:
            reading = self.guiReadings.readings[gageName]
            return reading['value']

        except:
            return "N/A"

    @Slot(str,str)
    def armValve(self, valveName:str, state:str):
        self.armedValves[valveName]=state
        print(valveName,":",state)

    @Slot(str, result=bool)
    def getValveState(self, valveName:str):
        #return true if valve is open
        try:
            reading = self.guiReadings.readings[valveName]
            if reading['value'] == 'OPENED_':
                return True
            else:
                return False

        except:
            self.guiReadings.push(valveName,'OPENED_','000000')
            return False

    
    @Slot(str, result=bool)
    def getArmState(self, valveName:str):
        #return true if valve is armed
        try:
            armed = self.armedValves[valveName]
            if armed == 'ARMED':
                return True
            else:
                return False

        except:
            return False

    @Slot()
    def sendCommand(self):
        telemetry.appendCommand(self.guiReadings)
        


def guiThreadFunc(inReadings:telemetry.Readings):

    #newobject = myClass()

    bridge = Bridge()

    bridge.guiReadings = inReadings
    

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
    

