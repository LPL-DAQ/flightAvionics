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
        self.connect = False #flag to determine if there is a secure connection
        #PT and TC data
        self.dataReadings = dict()
        #SV control data
        self.valveReadings = dict()
        #name timestamp
        self.armedValve = ("None", "")

        self.armedValves = dict()#check if still used
        
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
    def getPendLock(self):
        return self.pendLock

    def getArmedValve(self):
        return self.armedValve[0]
    
    def setArmedValve(self, name:str):
        self.armedValve = (name, timing.missionTime())

    def establishAddress(self, ip:str, port:int):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print(f"IP address: '{ip}' Port {port}")
        s.bind((ip, port))
        return s
    
    def closeSocket(self):
        self.socket.close()
        self.connect = False

    #waits for connection with client
    def establishConnection(self):
        s = self.establishAddress(self.ip, self.port)
        while not self.connect:
            print("Awaiting connection from client")
            s.listen(1)
            clientsocket, address = s.accept()
            
            self.socket = clientsocket
            self.connect = True

            print(f"Connection from {address} has been established.")
    
    #recieves all data from the PI
    def receiveData(self):
        msg = self.socket.recv(1024)
        msg = msg.decode("utf-8")
        data = msg.split("#")
        try:
            while data:
                if len(data[0]) != 0: #value
                    received_reading = data[0].split("/")
                    #print(received_reading) #print line for all received readings
                    if len(received_reading) == 3: #sensor reading
                        sensorName = received_reading[0]
                        sensorValue = received_reading[1]
                        time = received_reading[2]
                        self.dataReadings[sensorName] = sensorValue
                        self.fp.write(sensorName + " " + sensorValue + " " + time + "\n")
                        #print(name + " " + value + " " + time)

                    elif len(received_reading) == 2: #valve confirmation
                        valveName = received_reading[0]
                        valveState = received_reading[1]
                        #needs to be implemented 
                        self.verifyValve()
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
            return
        msg = "#" + valve + "/" + newState
        telemetry.sendMsg(self.getSocket(), msg)  

    def sendRegCmd(self, command):
        telemetry.sendMsg(self.getSocket(), command)
        
    #theres more logic to this but ill do it sometime
    def verifyValve(self):
        valve = self.armedValve
        print(valve[0], "command received in", timing.getTimeDiff(valve[1], timing.missionTime()))
             
    #code for multi valve command...needs some fix
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
    


         
            


            



