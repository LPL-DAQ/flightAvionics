import time
import socket
import threading

import queue
import timing
import telemetry
import serverThreads
import verify

class Server:
    def __init__(self, filepath:str) -> None:
        #server ini data
        self.serverIni = verify.verifyServerIni(filepath)
        #socket stuff
        self.ip, self.port = verify.getIPAddress(filepath)
        self.socket = None
        self.connect = False
        #PT and TC data
        self.dataReadings = dict()
        #SV control data
        self.pendingValves = dict()
        self.valveReadings = dict()
        self.armedValves = dict()
        self.commandQ = queue.Queue()
        
        self.workLock = threading.Lock()
        self.dataLock = threading.Lock()
        self.sockLock = threading.Lock()

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
    
    def closeSocket(self):
        self.lock.acquire()
        self.socket.close()
        self.connect = False
        self.lock.release()

    def establishConnection(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print(f"IP address: '{self.ip}' Port {self.port}")
        s.bind((self.ip,self.port))
        # try:
        #     s.bind((self.ip,self.port))
        # except:
        #     print("Error: Invalid ip address please change the ini file")
        while not self.connect:
            print("Awaiting connection from client")
            s.listen(1)
            clientsocket, address = s.accept()
            
            self.sockLock.acquire()
            self.socket = clientsocket
            self.connect = True
            self.sockLock.release()

            print(f"Connection from {address} has been established.")
    
    def receiveData(self):
        msg = self.s.recv(1024)
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
                        if name[:2] == "SV":
                            self.verfiyValve(name, value, time)
                        else:
                            self.dataLock.acquire()
                            self.dataReadings[name] = value
                            self.dataLock.release()
                            self.fp.write(name + " " + value + " " + time + "\n")

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
            self.pendingValves.update(valveName, (state, time))
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
                        continue
                    msg = "#" + valve + "/" + newState + "/" + time
                    self.commandQ.put(msg)
                    self.addValve(valve, newState, time) #adds to list of valves that have an outgoing command
                    print("SENDING", newState, "MSG FOR:", valve)
                else: #if there is deny command
                    print("ERROR:", valve, "COMMAND ALREADY SENT PLEASE WAIT")
    
    def verfiyValve(self, name:str, value:str, time:str):
        if name in self.pendingValves:
            currentState = self.valveReadings[name]
            self.removeValve(name)
            if self.valveReadings[name] != value:
                print("ERROR:", name, "received the wrong state")
            self.valveReadings[name] = value
            print("[", name, "] actuated in ", timing.getTimeDiff(time, timing.missionTime()), " seconds")  
                
        else:
            self.valveReadings[name] = value
            print("[", name, "] has successfully been initialized to ", value, sep = "")

         
            


            



