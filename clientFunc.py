import socket
import time
import threading

import verify
import telemetry
import timing 
import SVLib
import DRVLib

messengerLock = threading.Lock()


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
                    messengerLock.acquire()
                    telemetry.sendReading(sensorName, self.FVreadings.readings[sensorName], self.getSocket())
                    messengerLock.release()
                    time.sleep(period)
            except Exception as e:
                self.connected = False
                self.clientSocket.close()
                print("WARNING: Client has lost connection to the server")
                break

    def runClient(self):#persistant connection
        while True:
            try:
                self.clientIO()
                self.clientSocket = self.findConnection()
            except Exception as e:
                print(e)
                print("Something unexpected occurred ¯\_(ツ)_/¯")

    def receiveNExecute(self):#receives and executes a valve command
        while True:
            if self.connected:
                
                msg = self.clientSocket.recv(1024)
                
                msg = msg.decode("utf-8")
                data = msg.split("#")
                try:
                    #print(msg) print line for received readings
                    while data:
                        if len(data[0]) != 0:
                            received_reading = data[0].split("/")
                            print()
                            if received_reading[0] == "GM1": #ground command
                                print("Received ignition command")
                                timer= int(received_reading[2])
                                time.sleep(timer)
                                SVLib.groundCommands("IGNITION")
                            elif len(received_reading) == 2:
                                tag= received_reading[0] #find which item command corresponds to
                                valtype= tag[0] #find if "S" for solenoids or "R" for regulators 
                            if valtype == "S" or valtype == "P": 
                                name = received_reading[0]
                                value = received_reading[1]

                                self.FVstates.execute(name,value)#executes valve cmd
                                
                                msg = "#" + name + "/" + self.FVstates.getValveState(name)#creates confirmation msg
                                messengerLock.acquire()
                                telemetry.sendMsg(self.clientSocket, msg)
                                messengerLock.release()
                                print("MSG SENT")
                            elif valtype == "R":
                                name= received_reading[0]
                                direction= received_reading[1]
                                print("Received:", name, direction)
                                if direction == "CW":
                                    self.Regulators[name].motor_run(10000, 1)
                                    print("REG MOVED 10000 STEPS")
                                elif direction == "CCW":
                                    self.Regulators[name].motor_run(10000, 0)
                                    print("COMMAND SENT")
                                else:
                                    print("Command error")
                            else:
                                print("FUCKED UP MSG :)")
                        data.remove(data[0])
                
                        
                except Exception as e:
                    print("Exception", e)
        



