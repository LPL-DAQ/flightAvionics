import socket
import select
import time

import timing
import telemetry
import serverFunc

armedValves: dict = {}

class Readings:

    def __init__(self,PT_dict:dict,TC_dict:dict,SV_dict:dict):
        self.PTs = PT_dict
        self.TCs = TC_dict
        self.SVs = SV_dict
        self.readings = dict()
        self.refreshAll()
        
    #updates the value and timestamp for each value sequentially
    def refreshAll(self):
        for PT_name in self.PTs:
            new_reading = dict()
            new_reading['value']= "{:0>7.2f}".format(self.PTs[PT_name].pressure)
            new_reading['time']= self.PTs[PT_name].timeStamp
            new_reading['type']= 'PT'
            self.readings[PT_name] = new_reading

        for TC_name in self.TCs:
            new_reading = dict()
            temp = self.TCs[TC_name].temperature.get('f')
            new_reading['value']= "{:0>7.2f}".format(temp)
            new_reading['time']= self.TCs[TC_name].timeStamp
            new_reading['type']= 'TC'
            self.readings[TC_name] = new_reading

    def update(self,name:str,value:str,time:str):
        
        new_reading = dict()
        new_reading['value']= value
        new_reading['time']= time
        new_reading['type']= name[0:2]
        self.readings[name] = new_reading

    def execute(self,name:str,value:str,time:str):
        print("getting command " + name)
        if value == 'OPEN_':
            print("getting command 111111")
            self.SVs[name].openValve()
            
            self.update(name,'OPENED_',time)
        elif value == 'CLOSE':
            
            self.SVs[name].closeValve()
            
            self.update(name,'CLOSED_',time)

def sendReading(name:str, reading:dict, socket: socket.socket):
    value = reading['value']
    time =  reading['time']
    #readingType = reading['type']
    
    msg = "#" + name + "/" + value + "/" + time
    telemetry.sendMsg(socket, msg)

def getCommand(serverSocket:socket,FV_Readings:Readings):
    print("getting command")
    
    msg = serverSocket.recv(1024)
    msg = msg.decode("utf-8")

    data = msg.split("#")
    #print("msg = ",msg)
    
    
    while data:
        #print("data= ",data[0])
        if len(data[0]) == 22:
            
            received_reading = data[0].split("/")

            name = received_reading[0]
            value = received_reading[1]
            time = received_reading[2]
            
            FV_Readings.execute(name,value,time)

            print(received_reading)
            
            

        data.remove(data[0])

def receiveData(socket,readings:Readings, fp):

    msg = socket.recv(1024)
    
    if msg:
        msg = msg.decode("utf-8")
    else: #not sure if this will ever run...
        socket.close
        print("Connection Lost")
        raise Exception("Connection Lost")

    data = msg.split("#")
    #print("msg = ",msg)

    try:
        while data:
            
            if len(data[0]) == 24:
                #print("data= ",data[0])
                
                received_reading = data[0].split("/")

                name = received_reading[0]
                value = received_reading[1]
                time = received_reading[2]

                #GUI update func
                readings.update(name,value,time)
                #write to file func
                #need to change mission time ltr
                fp.write(name + " " + value + " " + timing.missionTime())
                #print to console
                print(name + " " + value + " " + timing.missionTime(), flush = True)

                #if name =='PTH001':
                #print ("Time: " + time)
                #logStamp = timing.getTimeDiffInSeconds(originTime, time)
                #print (name + " " + value + " " + timing.missionTime() , file = filename, flush = True)
                #print(data[0], file = sourceFile, flush=True)

            data.remove(data[0])
    except:
        print('Data processing error occured')
            


def appendCommand(inReadings:Readings, commandQ):
    for valve in armedValves:
        if armedValves[valve]=='ARMED':
            
            
            reading = inReadings.readings[valve]
            state = reading['value']

            if state == "OPENED_":
                #inReadings.push(valve,"CLOSES","00000")
                msg = "#" + valve + "/" + "CLOSE" + "/" + timing.missionTime() 
                #inReadings.push(valve,"CLOSED",time)
                print("Set",valve,"to CLOSED")
            else:
                #inReadings.push(valve,"OPENED","00000")
                msg = "#" + valve + "/" + "OPEN_" + "/" + timing.missionTime()
                #print("Set",valve,"to OPENED")
                inReadings.push(valve,"OPENED",time)

            commandQ.append(msg)


def sendCommand(FV_Socket:socket):
    while commands:
        
        msg = commands.pop()
        msg = str.encode(msg)
        FV_Socket.sendall(msg)

        print(msg)

config = dict()
    

