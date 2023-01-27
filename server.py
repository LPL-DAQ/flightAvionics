import time
import socket
import threading

import queue
import timing
import telemetry
import serverFunc

class Server:
    def __init__(self, filepath:str) -> None:
        self.commandQ = queue.Queue()
        self.orderQ = queue.Queue()
        self.dataReadings = dict()
        self.valveReadings = dict()
        self.fp = serverFunc.verifyServerIni(filepath, "server")
        self.ip, self.port = telemetry.getIPAddress(filepath)
        self.armedValves = dict()
        self.socket = None
        self.connect = False
        self.lock = threading.Lock()

    def getCommandQ(self):
        return self.commandQ
    
    def getOrderQ(self):
        return self.orderQ

    def getDataReadings(self):
        return self.dataReadings

    def getValveReadings(self):
        return self.valveReadings
    
    def getFilePointer(self):
        return self.fp

    def getIP(self):
        return self.ip

    def getPort(self):
        return self.port

    def getArmedValves(self):
        return self.armedValves

    def getSocket(self):
        return self.socket

    def getLock(self):
        return self.lock

    def isConnected(self):
        return self.connect
    
    def closeSocket(self):
        self.lock.acquire()
        self.socket.close()
        self.connect = False
        self.lock.release()

    def establishConnection(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print(f"IP adress: '{self.ip}' Port {self.port}")
        s.bind((self.ip,self.port))
        while not self.connect:
            print("Awaiting connection from client")
            s.listen(1)
            clientsocket, address = s.accept()
            
            self.lock.acquire()
            self.socket = clientsocket
            self.connect = True
            self.lock.release()

            print(f"Connection from {address} has been established.")
            



