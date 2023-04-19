from PySide6.QtCore import QThread
import time
import socket
import threading
import time

import queue
import timing
import telemetry
import serverFunc

#most of this is unused since we limited the valve commands to actuate one at a time

# def valveTimeOut(s:serverFunc.Server):
#     pendingValves = s.getPendingValves()
#     while True:
#         for i in pendingValves:
#             if timing.getTimeDiff(pendingValves[i][1], timing.missionTime()) > 5:
#                 print("WARNING:", i , "command timeout")
#                 s.removeValve(i)
#         time.sleep(1)
        

#thread function for dataReceiver 
def dataListener(s:serverFunc.Server):
    while True:
        if not s.isConnected():
            s.establishConnection()
        elif s.isConnected():
            try:
                s.receiveData()
            except Exception as e:
                print("ERROR1: Connection forcibly disconnected by host")
                s.setToNA();
                s.closeSocket()

#thread function for commandSender
# def valveCmd(s:serverFunc.Server):
#     while True:
#         if s.isConnected():
#             commands = s.getCommandQ()
#             try:
#                 if not commands.empty():
#                     msg = commands.get()
#                     s.getPendLock().acquire()
#                     telemetry.sendMsg(s.getSocket(), msg)
#                     s.getPendLock().release()
#             except:
#                 print("ERROR2: Connection forcibly disconnected by host")
#                 s.closeSocket()
#         else:
#             #Might need to fix ltr
#             time.sleep(5)

#sends valve commands to the PI
# class commandSender(QThread):
#     def __init__(self, s:serverFunc.Server) -> None:
#         super().__init__()
#         self.s = s

#     def run(self):
#         valveCmd(self.s)


#receives any and all data from the PI (PT and TC readings + SV confirm msgs)
class dataReceiver(QThread):

    def __init__(self, s:serverFunc.Server) -> None:
        super().__init__()
        self.s = s

    def run(self):
        dataListener(self.s)

#checks to see if any valve cmds have timed out
# class valveTimeOut(QThread):
#     def __init__(self, s:serverFunc.Server) -> None:
#         super().__init__()
#         self.s = s

#     def run(self):
#         valveTimeOut(self.s)


    
