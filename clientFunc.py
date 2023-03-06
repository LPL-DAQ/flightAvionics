import socket
import time
import threading

import verify
import telemetry
import timing 
import DRVLib

messengerLock = threading.Lock()


class Client:
    def __init__(self, filepath:str, FVreadings:telemetry.Readings, FVstates:telemetry.valveStates, Regulators:DRVLib.DRV8825) -> None:
        #TODO
        #self.clientIni = verify.verifyClientIni(filepath)
        self.FVreadings = FVreadings
        self.FVstates = FVstates
        self.Regulators= Regulators
        #pt_poll, sendrate
        self.clientIni = verify.verifyClientIni(filepath)
        
        #socket stuff
        self.connected = False
        self.ip, self.port = verify.getIPAddress(filepath)
        self.clientSocket = self.findConnection()

        self.messengerLock = threading.Lock()
        
    def getFVReadings(self):
        return self.FVreadings
    def getFVStates(self):
        return self.FVstates
    def getPTPoll(self) -> float:
        return self.clientIni["pt_poll"]
    def getSendRate(self) -> float:
        return self.clientIni["sendrate"]
    def isConnected(self) -> bool:
        return self.connected
    def getIP(self):
        return self.ip
    def getPort(self):
        return self.port
    def getSocket(self):
        return self.clientSocket

    def findConnection(self):
        while True:
            try:
                print("Looking for server")
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.connect((self.ip, self.port))
                s.setblocking(1) #might change to settimeout
                
                self.connected = True
                
                print("Connection established with server. IP:{}    port:{}".format(self.ip , self.port))
                return s
            except Exception as e:
                print(e)
                print("Could not connect...retrying in 5 seconds")
                time.sleep(5)

    def clientIO(self):
        period = 1/self.clientIni["sendrate"]
        print("Starting data stream...")
        while True:
            self.FVreadings.refreshAll()
            try:
                for sensorName in self.FVreadings.readings:
                    messengerLock.acquire()
                    telemetry.sendReading(sensorName, self.FVreadings.readings[sensorName], self.getSocket())
                    messengerLock.release()
                    time.sleep(period)
            except Exception as e:
                #remove this ltr
                print(e)
                self.connected = False
                self.clientSocket.close()
                print("WARNING: Client has lost connection to the server")
                break

    def runClient(self):
        while True:
            try:
                self.clientIO()
                self.clientSocket = self.findConnection()
            except Exception as e:
                print(e)
                print("something unexpected occurred ¯\_(ツ)_/¯")

    def receiveNExecute(self):
        while True:
            if self.connected:
                
                msg = self.clientSocket.recv(1024)
                
                msg = msg.decode("utf-8")
                data = msg.split("#")
                try:
                    print(msg)
                    while len(data) != 0:
                        if len(data[0]) != 0:
                            received_reading = data[0].split("/")
                            tag= received_reading[0] #find which item command corresponds to
                            type= tag[0] #find if "S" for solenoids or "R" for regulators 
                            if type == "S": 
                                name = received_reading[0]
                                value = received_reading[1]
                                print("Received:", name, value)
                                self.FVstates.execute(name,value)
                                print("SENDING")
                                
                                msg = "#" + name + "/" + self.FVstates.getValveState(name)
                                messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                messengerLock.release()
                                print("MSG SENT")
                            elif type == "R":
                                name= received_reading[0]
                                direction= received_reading[1]
                                print("Received:", name, direction)
                                if direction == "CW":
                                    self.Regulators.motor_run(5, 1)
                                    print("COMMAND SENT")
                                elif direction == "CCW":
                                    self.Regulators.motor_run(5, 0)
                                    print("COMMAND SENT")
                                else:
                                    print("Command error")
                            else:
                                print("FUCKED UP MSG :)")
                        data.remove(data[0])
                
                        
                except Exception as e:
                    print("Exception", e)
        




