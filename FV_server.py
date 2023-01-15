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
def establishConnection(ip:int, port:int):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print(f"IP adress: '{ip}' Port {port}")
    s.bind((ip,port))
    print("listening")
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
    def __init__(self, s, commands, lock, readings) -> None:
        super().__init__()
        self.socket = s
        self.commands = commands
        self.lock = lock
        self.readings = readings

    def run(self):
        valveCmd(self.socket, self.commands, self.lock, self.readings)


#receives any and all data from the PI (PT and TC readings + SV confirm msgs)
class dataReceiver(QThread):

    def __init__(self, s, readings, fp) -> None:
        super().__init__()
        self.socket = s
        self.readings= readings
        self.fp = fp

    def run(self):
        dataListener(self.socket, self.readings, self.fp)

class masterThread(QThread):
    def __init__(self, commands, fp, lock, readings, iniData) -> None:
        super().__init__()
        self.commands = commands
        self.lock = lock
        self.readings = readings
        self.fp = fp
        self.ini = iniData
        self.worker1 = dataReceiver(None, self.readings, self.fp)
        self.worker2 = commandSender(None, self.commands, self.lock, self.readings)

    def run(self):
        s = establishConnection(self.ini["ip"], int(self.ini["port"]))
        self.worker1.socket = s
        self.worker2.socket = s

        self.worker1.start()
        self.worker2.start()




def main():
    iniData = telemetry.parseIniFile("configFiles/config.ini", "server")
    #initialize phase goes here
    lock = threading.Lock()
    #s = establishConnection(iniData["ip"], int(iniData["port"])) 
    commandQ = serverFunc.commandQ
    readings = serverFunc.readings
    fp =  open("data/" + iniData["saveFile"] + str(timing.missionTime()), 'w')

    # worker1 = dataReceiver(s, readings, fp)
    # worker2 = commandSender(s, commandQ, lock, readings)
    worker3 = masterThread(commandQ, fp, lock, readings, iniData)
    worker3.start()
    # worker1.run()
    # worker2.run()

    #console thread start here
    gui.guiThreadFunc(readings) 

#runs server function
main()