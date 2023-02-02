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
        self.address = self.establishAddress(self.ip, self.port)
        self.connect = False
        #PT and TC data
        self.dataReadings = dict()
        #SV control data
        self.pendingValves = []
        self.valveReadings = dict()
        self.armedValves = dict()
        self.commandQ = queue.Queue()
        
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
    def getArmedValves(self):
        return self.armedValves
    def getValveReadings(self):
        return self.valveReadings
    def getCommandQ(self):
        return self.commandQ  
    def getPendingValves(self):
        return self.pendingValves
    def getPendLock(self):
        return self.pendLock

    def establishAddress(self, ip:str, port:int):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print(f"IP address: '{ip}' Port {port}")
        s.bind((ip, port))
        return s
    
    def closeSocket(self):
        #self.sockLock.acquire()
        self.socket.close()
        self.connect = False
        #self.sockLock.release()

    def establishConnection(self):
        # try:
        #     s.bind((self.ip,self.port))
        # except:
        #     print("Error: Invalid ip address please change the ini file")
        while not self.connect:
            print("Awaiting connection from client")
            self.address.listen(1)
            clientsocket, address = self.address.accept()
            
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
                    if len(received_reading) == 3:
                        name = received_reading[0]
                        value = received_reading[1]
                        time = received_reading[2]
                        self.dataReadings[name] =  value 
                        #self.fp.write(name + " " + value + " " + time + "\n")
                        #print(name + " " + value + " " + time)
                    elif len(received_reading) == 2:
                        valve = received_reading[0]
                        state = received_reading[1]
                        self.verifyValve(name, value)
                        self.valveReadings[name] = value
                    else:
                        print("WARNING: Malformed message received", data[0])
                data.remove(data[0])
        except Exception as e:
            print(e)
            print('Data processing error occured')
            
    
    def removeValve(self, valveName:str):
        if valveName in self.pendingValves:
            self.workLock.acquire()
            self.pendingValves.pop(valveName)
            self.workLock.release()
            return True
        else:
            print("ERROR:", valveName, "Message Never Sent")
            return False
    
    def addValve(self, valveName:str, state:str, time:str):
        if valveName not in self.pendingValves:
            self.workLock.acquire()
            self.pendingValves[valveName] = (state, time)
            self.workLock.release()
            return True
        else:
            print("ERROR:", valveName, "already in work queue")
            return False
    
    def checkValve(self, valveName:str) -> bool:
        return valveName in self.pendingValves

    #adds all valves that are armed to the commandQ
    def appendCommandQ(self):
        armedValves = self.armedValves
        for valve in armedValves:
            if armedValves[valve] == "ARMED":
                if not self.checkValve(valve): #if there isn't an ongoing command for that valve 
                    state = self.valveReadings[valve]
                    time = timing.missionTime()
                    if state == "OFF":
                        newState = "ON"
                        msg = "#" + valve + "/ON/" + time
                    elif state == "ON":
                        newState = "OFF"
                    else:#test msg for debug purposes :3
                        print("FUCKED UP VALVE CMD MSG BUDDY")
                        print("State:", state)
                        continue
                    msg = "#" + valve + "/" + newState
                    self.commandQ.put(msg)
                    self.addValve(valve, newState, time) #adds to list of valves that have an outgoing command
                    print("SENDING", newState, "MSG FOR:", valve)
                else: #if there is deny command
                    print("ERROR:", valve, "COMMAND ALREADY SENT PLEASE WAIT")
    
    def verifyValve(self, name:str, value:str, time:str):
        if name in self.pendingValves:
            self.removeValve(name)
            if self.valveReadings[name] != value:
                print("ERROR:", name, "received the wrong state")
            self.valveReadings[name] = value
            print("[", name, "] actuated in ", timing.getTimeDiff(time, timing.missionTime()), " seconds")  
                
        else:
            self.valveReadings[name] = value
            print("[", name, "] has successfully been initialized to ", value, sep = "")

         
            


            



