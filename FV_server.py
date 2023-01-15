from PySide6.QtCore import QThread
import concurrent.futures
import threading
import queue

import telemetry
import timing
import readings
import gui
import socket
import serverFunc

#establishes a connection between client and server
def establishConnection(ip:str, port:int):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print(f"IP adress: '{ip}' Port {port}")
    s.bind((ip,port))
    s.listen(1)
    clientsocket, address = s.accept()
    print(f"Connection from {address} has been established.")
    return clientsocket

def dataListener(s:socket.socket, readings, fp):
    try:
        while True:
            readings.receiveData(s, readings, fp)
    except:
        print("ERROR: Connection forcibly disconnected by host")

def valveCmd(s:socket.socket, commands:queue.Queue, lock:threading.Lock, readings):
    try:
        while True:
            if not commands.empty():
                msg = commands.pop()
                lock.acquire()
                telemetry.sendMsg(s, msg)
                lock.release()
    except:
         print("ERROR: Connection forcibly disconnected by host")

#sends valve commands to the PI
class commandSender(QThread):
    def __init__(self, s, commands, lock) -> None:
        self.socket = s
        self.commands = commands
        self.lock = lock
        #self.readings = readings

    def run(self):
        valveCmd(self.socket, self.commands, self.lock)


#receives any and all data from the PI (PT and TC readings + SV confirm msgs)
class dataReceiver(QThread):

    def __init__(self, s, readings, fp) -> None:
        self.socket = s
        self.readings= readings
        self.fp = fp

    def run(self):
        telemetry.dataListener(self.socket, self.readings, self.filename)

def main():
    readings = telemetry.Readings({},{},{})
    iniData = telemetry.parseIniFile("configFiles/config.ini", "server")
    #initialize phase goes here
    lock = threading.Lock()
    s = establishConnection(iniData["ip"], iniData["port"])
    commandQ = serverFunc.commandQ

    fp =  open(iniData["saveFile"] + str(timing.missionTime()), 'w')

    worker1 = dataReceiver(s, readings, fp)
    worker2 = commandSender(s, commandQ, lock)

    worker1.run()
    worker2.run()

    #console thread start here
    gui.guiThreadFunc(readings, iniData["ip"], iniData["port"]) 

#runs server function
main()