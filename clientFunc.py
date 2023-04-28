import socket
import time
import threading

import verify
import telemetry
import timing 
import SVLib
import DRVLib

import queue

class Client:

    def __init__(self, filepath:str, FVreadings:telemetry.Readings, valveStates:telemetry.valveStates, regStates:dict, Regulators:DRVLib.DRV8825) -> None:
        #TODO
        #self.clientIni = verify.verifyClientIni(filepath)

        self.FVreadings = FVreadings
        #valve states
        self.valveStates = valveStates
        self.regStates = regStates
        self.Regulators= Regulators
        #pt_poll, sendrate
        self.clientIni = verify.verifyClientIni(filepath)
        
        #socket stuff
        self.connected = False
        self.ip, self.port = verify.getIPAddress(filepath)
        #self.clientSocket = self.findConnection()
        self.clientSocket = None

        self.messengerLock = threading.Lock()
        self.workQ = queue.Queue()
        self.abortLock = threading.Lock()
        self.abort = False #abort check
        self.launchStop = False
        self.midLaunch = False
        
    #standard getter methods
    def getFVReadings(self):
        return self.FVreadings
    def getValveStates(self):
        return self.valveStates
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
    
    def isAReg(self, name:str): #true if it is a regulator
        if name in self.regStates:
            return True
        return False

    def isAValve(self, name:str): #true if it is a valve
        return self.valveStates.isAValve(name)
    
    def isASensor(self, name:str): #true if it is a sensor
        return self.FVreadings.isASensor(name)

    def sendCurrValveStates(self):
        for i in self.valveStates:
            if self.valveStates[i] == -1:
                msgStr = "UNIT"
            elif self.valveStates[i] == 0:
                msgStr = "OFF"
            else:
                msgStr = "ON"
            self.messengerLock.acquire()
            telemetry.sendReading(i, msgStr, self.getSocket())
            self.messengerLock.release()


    #attempts to establish a connection with the server.
    def findConnection(self):
        while True:
            try:
                print("Looking for server")
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.connect((self.ip, self.port))
                s.setblocking(1)
                
                self.connected = True
                
                print("Connection established with server. IP:{}    port:{}".format(self.ip , self.port))
                return s
            except Exception as e:#If connection fails try again in 5 seconds
                print("Could not connect...retrying in 5 seconds")
                time.sleep(5)

    def clientIO(self): #client send data function 
        period = self.clientIni["sendrate"] #gets the period
        print("Starting data stream...")
        while self.connected:#false the first time it runs
            self.FVreadings.refreshAll() #polls all values sequentially...might be able to optimize
            try:
                for sensorName in self.FVreadings.readings:#sends the reading
                    self.messengerLock.acquire()
                    telemetry.sendReading(sensorName, self.FVreadings.readings[sensorName], self.getSocket())
                    self.messengerLock.release()
                    time.sleep(period)
            except Exception as e:
                self.connected = False #set the flag to false 
                print("WARNING: Client has lost connection to the server")
                if not self.attemptReconnect():
                    self.clientSocket.close() #close the socket
                    self.connected = False

    def attemptReconnect(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(15)
            s.connect((self.ip, self.port))
            s.setblocking(1)
            s.settimeout(None)
            return True
        except Exception as e:
            print("Reconnect attempt failed...aborting")
            for i in self.valveStates.SVs:
                self.valveStates.execute(i, "OFF")
            return False


        

    def runClient(self):#persistant connection
        while True:
            try:
                self.clientSocket = self.findConnection() #set up the connection
                self.sendCurrValveState()
                self.clientIO()
            except Exception as e:
                print(e)
                print("Something unexpected occurred ¯\_(ツ)_/¯")

    def receiveCMD(self):
        while self.connected:
            msg = self.clientSocket.recv(1024)
            msg = msg.decode("utf-8")
            data = msg.split("#")
            try:
                while data:
                    if len(data[0]) != 0: #when split we get might get an empty string
                        print(data[0])
                        received_reading = data[0].split("/")
                        #if len(received_reading) == 2 and received_reading[0][0] == "R" and received_reading[1] == "STOP":#hard check for now
                        if len(received_reading) == 1:
                            if received_reading[0] == "ABORT": #abort implementation
                                self.abort = True
                                for i in self.valveStates.SVs:
                                    self.valveStates.execute(i, "OFF")
                                msg = "#ABORTED/" + timing.missionTime()
                                self.messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                self.messengerLock.release()
                                self.sendCurrValveStates()
                                self.abort = False
                            elif(received_reading[0] == "STOPLAUNCH"):
                                if self.midLaunch:
                                    self.launchStop = True
                                else:
                                    print("STOP CMD IGNORED")

                        elif len(received_reading) == 2 and self.isAReg(received_reading[0]) and received_reading[1] == "STOP":
                            print("Received stop command")
                            self.Regulators[received_reading[0]].abortRun()
                        else:   
                            self.workQ.put(data[0]) 
                    data.remove(data[0])
            except Exception as e:
                print("ERROR: Invalid CMD", data[0])

    def launch(self):
        for i in range(0, 8):
            if self.launchStop or self.abort:
                return False
            time.sleep(1)
        self.valveStates.execute("EBV0101", "ON")
        msg = "#EBV0101/" + self.FVstates.getValveState("EBV0101") + "/" + timing.missionTime()#creates confirmation msg
        self.messengerLock.acquire()
        telemetry.sendMsg(self.clientSocket, msg)
        self.messengerLock.release()
        for i in range(0, 17):
            if self.abort:
                return False
            time.sleep(.1)
        self.valveStates.execute("PBVF201", "ON")
        msg = "#PBVF201/" + self.FVstates.getValveState("PBVF201") + "/" + timing.missionTime()#creates confirmation msg
        self.messengerLock.acquire()
        telemetry.sendMsg(self.clientSocket, msg)
        self.messengerLock.release()
        for i in range(0, 43):
            if self.abort:
                return False
            time.sleep(.1)
        self.valveStates.execute("EBV0101", "OFF")
        msg = "#EBV0101/" + self.FVstates.getValveState("EBV0101") + "/" + timing.missionTime()#creates confirmation msg
        self.messengerLock.acquire()
        telemetry.sendMsg(self.clientSocket, msg)
        self.messengerLock.release()
        for i in range(0, 38):
            if self.abort:
                return False
            time.sleep(.1)
        self.valveStates.execute("PBVF201", "OFF")
        msg = "#PBVF201/" + self.FVstates.getValveState("PBVF201") + "/" + timing.missionTime()#creates confirmation msg
        self.messengerLock.acquire()
        telemetry.sendMsg(self.clientSocket, msg)
        self.messengerLock.release()
        time.sleep(0.2)
        self.valveStates.execute("SVN007", "ON")
        self.valveStates.execute("SVN008", "ON")
        msg = "#SVN007/" + self.FVstates.getValveState("PBVF201") + "/" + timing.missionTime() + "#SVN007/" + self.FVstates.getValveState("SVN008") + "/" + timing.missionTime()#creates confirmation msg
        self.messengerLock.acquire()
        telemetry.sendMsg(self.clientSocket, msg)
        self.messengerLock.release()
        return True


    
    def executeCMD(self):
        while self.connected:
            if not self.workQ.empty():
                try:
                    received_reading = self.workQ.get().split("/")
                    if not self.abort:
                        if len(received_reading) == 1:
                            if received_reading[0] == "LAUNCH":
                                self.midLaunch = True
                                if self.launch():
                                    msg = "#LAUNCH/DONE/" + timing.missionTime()
                                else:
                                    msg = "#LAUNCH/ABORTED/" + timing.missionTime()
                                
                                self.messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                self.messengerLock.release()
                                self.sendCurrValveStates()
                                self.launchStop = False
                                self.midLaunch = False

                        elif len(received_reading) == 2:
                            valveName = received_reading[0]
                            #valveType = valveName[0]
                            #if valveType == "S" or valveType == "P": #solenoid or pneumatic
                            if self.isAValve(valveName):
                                name = received_reading[0]
                                value = received_reading[1]
                                self.FVstates.execute(name,value)#executes valve cmd
                                msg = "#" + name + "/" + self.FVstates.getValveState(name) + "/" + timing.missionTime()#creates confirmation msg
                                self.messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                self.messengerLock.release()
                            #elif valveType == "R": #regulator
                            elif self.isAReg(valveName):
                                name = received_reading[0]
                                command= received_reading[1]
                                if command == "CW":
                                    try:
                                        self.Regulators[name].motor_run(10000, 1)
                                        #send some msg here
                                    except Exception as e:
                                        #send abort conf here
                                        print(name, " finished prematurely due to abort")
                                elif command == "CCW":
                                    try:
                                        self.Regulators[name].motor_run(10000, 0)
                                        #send some msg here
                                    except Exception as e:
                                        #send abort conf here
                                        print(name, " finished prematurely due to abort")
                                # elif command == "STOP":
                                #     self.Regulators[name].abortRun()
                                else:
                                    print("ERROR: Invalid CMD for", name)
                        elif len(received_reading) == 3:
                            if received_reading[0] == "GM1": #ground command
                                print("Received ignition command")
                                timer = int(received_reading[2])
                                time.sleep(timer)
                                SVLib.groundCommands("IGNITION")
                except Exception as e:
                    print("ERROR:", received_reading, "FAILED TO EXECUTE")
        



