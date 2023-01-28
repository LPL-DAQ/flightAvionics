from PySide6.QtCore import QThread
import time
import socket
import threading
import time

import queue
import timing
import telemetry
import serverFunc

def valveTimeOut(s:serverFunc.Server):
    pendingValves = s.getPendingValves()
    while True:
        for i in pendingValves:
            if timing.getTimeDiff(pendingValves[i][2], timing.missionTime()) > 5:
                print("WARNING:", i, " timeout occurred")
                s.removeValve(i)
        time.sleep(1)
        

#thread function for dataReceiver 
def dataListener(s:serverFunc.Server):
    while True:
        s.establishConnection()
        if s.isConnected():
            try:
                serverFunc.receiveData(s.getSocket(), s.getDataReadings(), s.getFilePointer())
            except Exception as e:
                print("ERROR1: Connection forcibly disconnected by host")
                s.closeSocket()

#thread function for commandSender
def valveCmd(s:serverFunc.Server):
    while True:
        if s.isConnected:
            commands = s.getCommandQ()
            try:
                if not commands.empty():
                    msg = commands.get()
                    #lock.acquire()
                    telemetry.sendMsg(s.getSocket(), msg)
                    #lock.release()
            except:
                print("ERROR2: Connection forcibly disconnected by host")
                s.closeSocket()
        else:
            #Might need to fix ltr
            time.sleep(5)

#sends valve commands to the PI
class commandSender(QThread):
    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s

    def run(self):
        valveCmd(self.s)


#receives any and all data from the PI (PT and TC readings + SV confirm msgs)
class dataReceiver(QThread):

    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s

    def run(self):
        dataListener(self.s)

class valveTimeOut(QThread):
    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s

    def run(self):
        valveTimeOut(self.s)


    
