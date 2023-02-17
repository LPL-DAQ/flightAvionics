import socket
import threading

import telemetry
import queue
import timing
import verify

class Server:
    def __init__(self, filepath:str) -> None:
        #server ini data
        self.serverIni = verify.verifyServerIni(filepath)
        self.fp = self.serverIni["fp"]
        #socket stuff
        self.ip, self.port = verify.getIPAddress(filepath)
        self.socket = None
        self.address = None
        self.connect = False
        #PT and TC data
        self.dataReadings = dict()
        #SV control data
        self.valveReadings = dict()
        #name timestamp
        self.armedValve = ("None", "")
        #self.pendingValves = dict()
        self.armedValves = dict()
        #self.commandQ = queue.Queue()
        
        self.pendLock = threading.Lock()

    #standard getter methods
    def getDataReadings(self):
        return self.dataReadings
    def getFilePointer(self):
        return self.serverIni["fp"]
    def getIP(self):
        return self.ip
    def getPort(self):
        return self.port
    def getSocket(self):
        return self.socket
    def getLock(self):
        return self.lock
    def isConnected(self):
        return self.connect
    def getValveReadings(self):
        return self.valveReadings
    def getArmedValves(self):
        return self.armedValves
    # def getCommandQ(self):
    #     return self.commandQ  
    # def getPendingValves(self):
    #     return self.pendingValves
    def getPendLock(self):
        return self.pendLock

    def getArmedValve(self):
        return self.armedValve[0]
    
    def setArmedValve(self, name:str):
        self.armedValve = (name, timing.missionTime())

    def establishAddress(self, ip:str, port:int):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print("TESTING")
        print(f"IP address: '{ip}' Port {port}")
        s.bind((ip, port))
        return s
    
    def closeSocket(self):
        self.socket.close()
        self.connect = False

    def establishConnection(self):
        # try:
        #     s.bind((self.ip,self.port))
        # except:
        #     print("Error: Invalid ip address please change the ini file")
        s = self.establishAddress(self.ip, self.port)
        while not self.connect:
            print("Awaiting connection from client")
            s.listen(1)
            clientsocket, address = s.accept()
            
            #self.sockLock.acquire()
            self.socket = clientsocket
            self.connect = True
            #self.sockLock.release()

            print(f"Connection from {address} has been established.")
    
    def receiveData(self):

        
        msg = self.socket.recv(1024)
        msg = msg.decode("utf-8")
        data = msg.split("#")
        try:
            while data:
                if len(data[0]) != 0: #value
                    received_reading = data[0].split("/")
                    #print(received_reading)
                    if len(received_reading) == 3:
                        sensorName = received_reading[0]
                        sensorValue = received_reading[1]
                        time = received_reading[2]
                        self.dataReadings[sensorName] = sensorValue
                        self.fp.write(sensorName + " " + sensorValue + " " + time + "\n")
                        #print(name + " " + value + " " + time)
                    elif len(received_reading) == 2:
                        print("THis triggered")
                        valveName = received_reading[0]
                        valveState = received_reading[1]
                        #add this later :)
                        self.verifyValve()
                        #self.removeValve(valveName)
                        self.valveReadings[valveName] = valveState
                    else:
                        print("WARNING: Malformed message received", data[0])
                data.remove(data[0])
        except Exception as e:
            print(e)
            print('Data processing error occured')
            
    def sendValveCmd(self, valve:str):
        if not self.isConnected:
            print("WARNING: No Connection")
            return
        state = self.valveReadings[valve]
        time = timing.missionTime()
        if state == "OFF":
            newState = "ON"
        elif state == "ON":
            newState = "OFF"
        else:#test msg for debug purposes :3
            print("FUCKED UP VALVE CMD MSG BUDDY")
            print("State:", state)
        msg = "#" + valve + "/" + newState
        telemetry.sendMsg(self.getSocket(), msg)  

    def sendTimingCmd(self, timer, igniter, lox, fuel):
        if not self.isConnected:
            print("WARNING: No Connection")
            return
        msg= "#"+ timer + "/" + igniter + "/" + lox + "/" + fuel
        telemetry.sendMsg(self.getSocket(), msg)  

    #theres more logic to this but ill do it sometime
    def verifyValve(self):
        valve = self.armedValve
        print(valve[0], "command received in", timing.getTimeDiff(valve[1], timing.missionTime()))
             

    # def removeValve(self, valveName:str):
    #     if valveName in self.pendingValves:
    #         self.pendLock.acquire()
    #         del self.pendingValves[valveName]
    #         self.pendLock.release()
    #         return True
    #     else:
    #         print("ERROR:", valveName, "Message Never Sent")
    #         return False
    
    # def addValve(self, valveName:str, state:str, time:str):
    #     if valveName not in self.pendingValves:
    #         self.pendLock.acquire()
    #         self.pendingValves[valveName] = (state, time)
    #         self.pendLock.release()
    #         return True
    #     else:
    #         print("ERROR:", valveName, "already in work queue")
    #         return False
    
    # def checkValve(self, valveName:str) -> bool:
    #     return valveName in self.pendingValves

    #adds all valves that are armed to the commandQ
    # def appendCommandQ(self):
    #     armedValves = self.armedValves
    #     for valve in armedValves:
    #         if armedValves[valve] == "ARMED":
    #             if not self.checkValve(valve): #if there isn't an ongoing command for that valve 
    #                 state = self.valveReadings[valve]
    #                 time = timing.missionTime()
    #                 if state == "OFF":
    #                     newState = "ON"
    #                     msg = "#" + valve + "/ON/" + time
    #                 elif state == "ON":
    #                     newState = "OFF"
    #                 else:#test msg for debug purposes :3
    #                     print("FUCKED UP VALVE CMD MSG BUDDY")
    #                     print("State:", state)
    #                     continue
    #                 msg = "#" + valve + "/" + newState
    #                 self.commandQ.put(msg)
    #                 self.addValve(valve, newState, time) #adds to list of valves that have an outgoing command
    #                 print("SENDING", newState, "MSG FOR:", valve)
    #             else: #if there is deny command
    #                 print("ERROR:", valve, "COMMAND ALREADY SENT PLEASE WAIT")
    


         
            


            



