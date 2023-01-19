from PySide6.QtCore import QThread
import concurrent.futures
import threading
import queue
import time

import telemetry
import timing
import gui
import socket
import serverFunc


#establishes a connection between client and server
def establishConnection(ip:int, port:int):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print(f"IP adress: '{ip}' Port {port}")
    s.bind((ip,port))
    while True:
        if not serverFunc.connected:
            print("listening")
            s.listen(1)
            clientsocket, address = s.accept()
            serverFunc.serverSocket = clientsocket
            print(f"Connection from {address} has been established.")
            serverFunc.connected = True
        #do not need to check that frquently
        time.sleep(5)
        

def dataListener(dataReadings, fp):
    while True:
        if serverFunc.connected:
            try:
                serverFunc.receiveData(serverFunc.serverSocket, dataReadings, fp)
            except Exception as e:
                print("ERROR1: Connection forcibly disconnected by host")
                serverFunc.serverSocket.close()
                serverFunc.connected = False

def valveCmd(commands:queue.Queue, lock:threading.Lock):
    while True:
        if serverFunc.connected:
            try:
                if not commands.empty():
                    msg = commands.get()
                    #lock.acquire()
                    telemetry.sendMsg(serverFunc.serverSocket, msg)
                    #lock.release()
            except:
                print("ERROR2: Connection forcibly disconnected by host")
                serverFunc.serverSocket.close()
                serverFunc.connected = False

#sends valve commands to the PI
class commandSender(QThread):
    def __init__(self, commands, lock, readings) -> None:
        super().__init__()
        self.commands = commands
        self.lock = lock
        self.readings = readings

    def run(self):
        valveCmd(self.commands, self.lock)


#receives any and all data from the PI (PT and TC readings + SV confirm msgs)
class dataReceiver(QThread):

    def __init__(self, readings, fp) -> None:
        super().__init__()
        self.readings= readings
        self.fp = fp

    def run(self):
        dataListener(self.readings, self.fp)

class masterThread(QThread):
    def __init__(self, ip:str, port:int) -> None:
        super().__init__()
        self.ip = ip
        self.port = port

    def run(self):
        establishConnection(self.ip, int(self.port))

def main():
    #iniData = telemetry.parseIniFile("configFiles/config.ini", "server")
    serverDict = serverFunc.verifyServerIni("configFiles/config.ini", "server")
    if serverDict == None:
        print("File rejected for the following reasons ^")
        return 0
    #initialize phase goes here
    lock = threading.Lock()
    #s = establishConnection(iniData["ip"], int(iniData["port"])) 
    #fp = open("data/" + iniData["saveFile"] + str(timing.missionTime()), 'w')

    # worker1 = dataReceiver(s, readings, fp)
    # worker2 = commandSender(s, commandQ, lock, readings)
    
    worker1 = masterThread(serverDict["ip"], serverDict["port"])
    worker2 = dataReceiver(serverFunc.dataReadings, serverDict["fp"])
    worker3 = commandSender(serverFunc.commandQ, lock, serverFunc.SVdata)
    worker1.start()
    worker2.start()
    worker3.start()


    #console thread start here
    gui.guiThreadFunc(serverFunc.dataReadings, serverFunc.armedValves) 

#runs server function
main()