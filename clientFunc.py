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

    def __init__(self, filepath:str, FVreadings:telemetry.Readings, FVstates:telemetry.valveStates, Regulators:DRVLib.DRV8825) -> None:
        #TODO
        #self.clientIni = verify.verifyClientIni(filepath)

        self.FVreadings = FVreadings
        #valve states
        self.FVstates = FVstates
        self.Regulators= Regulators
        #pt_poll, sendrate
        self.clientIni = verify.verifyClientIni(filepath)
        
        #socket stuff
        self.connected = False
        self.ip, self.port = verify.getIPAddress(filepath)
        self.clientSocket = self.findConnection()

        self.messengerLock = threading.Lock()
        self.workQ = queue.Queue()
        
    #standard getter methods
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
        while True:
            self.FVreadings.refreshAll() #polls all values sequentially...might be able to optimize
            try:
                for sensorName in self.FVreadings.readings:#sends the reading
                    self.messengerLock.acquire()
                    telemetry.sendReading(sensorName, self.FVreadings.readings[sensorName], self.getSocket())
                    self.messengerLock.release()
                time.sleep(period) #should send every sensor then sleep
            except Exception as e:
                self.connected = False
                self.clientSocket.close()
                self.FVstates.abort()
                print("WARNING: Client has lost connection to the server")
                break

    def runClient(self):#persistant connection
        while True:
            try:
                self.clientIO()
                self.clientSocket = self.findConnection()
                print("Connection ran")
            except Exception as e:
                print(e)
                print("Something unexpected occurred ¯\_(ツ)_/¯")

    def receiveCMD(self):
        while True:
            if self.connected:
                msg = self.clientSocket.recv(1024)
                msg = msg.decode("utf-8")
                data = msg.split("#")
                try:
                    received_reading = self.workQ.get().split("/")
                    if len(received_reading) == 2:
                        valveName = received_reading[0]
                        valveType = valveName[0]
                        if valveType == "S" or valveType == "P": #solenoid or pneumatic
                            name = received_reading[0]
                            value = received_reading[1]
                            self.FVstates.execute(name,value)#executes valve cmd
                            msg = "#" + name + "/" + self.FVstates.getValveState(name)#creates confirmation msg
                            self.messengerLock.acquire()
                            telemetry.sendMsg(self.clientSocket, msg)
                            self.messengerLock.release()
                        elif valveType == "R": #regulator
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
                            else:
                                print("ERROR: Invalid CMD for", name)
                    elif len(received_reading) == 5: #timing sequence
                        print("Received Timing")
                        igniter= received_reading[2]
                        lox= received_reading[3]
                        fuel= received_reading[4]
                        timing=[igniter, lox, fuel]
                        SVLib.timingSequence(timing)
                    elif len(received_reading) == 3:
                        if received_reading[0] == "GM1": #ground command
                            print("Received ignition command")
                            timer= int(received_reading[2])
                            time.sleep(timer)
                            SVLib.groundCommands("IGNITION")
                except Exception as e:
                    print("ERROR: Invalid CMD", data[0])
    
    def executeCMD(self):
        while True:
            if self.connected:
                if not self.workQ.empty():
                    try:
                        received_reading = self.workQ.get().split("/")
                        if len(received_reading) == 2:
                            valveName = received_reading[0]
                            valveType = valveName[0]
                            if valveType == "S" or valveType == "P": #solenoid or pneumatic
                                name = received_reading[0]
                                value = received_reading[1]
                                self.FVstates.execute(name,value)#executes valve cmd
                                msg = "#" + name + "/" + self.FVstates.getValveState(name)#creates confirmation msg
                                self.messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                self.messengerLock.release()
                            elif valveType == "R": #regulator
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
                                timer= int(received_reading[2])
                                time.sleep(timer)
                                SVLib.groundCommands("IGNITION")
                    except Exception as e:
                        print("ERROR:", received_reading, "FAILED TO EXECUTE")
        



