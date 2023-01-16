import socket
from configparser import ConfigParser

class Readings:

    def __init__(self,PT_dict:dict,TC_dict:dict):
        self.PTs = PT_dict
        self.TCs = TC_dict
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

    def getData(self, name:str):
        return self.readings[name]
    
    def update(self,name:str,value:str,time:str):
        new_reading = dict()
        new_reading['value']= value
        new_reading['time']= time
        new_reading['type']= name[0:2]
        self.readings[name] = new_reading
        

class valveStates:
    def __init__(self, SV_dict:dict) -> None:
        self.SVs = SV_dict
        self.states = dict()

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


def parseIniFile(filepath, consoleType):
    iniParser = ConfigParser()
    try:
        with open(filepath) as f:
            iniParser.read_file(f)
    except IOError:
        print("ERROR:", filepath, "is missing")
        return None
    
    if consoleType not in iniParser.sections():
        print("ERROR: Invalid file for:", consoleType)
        return None
    
    #validation here
    return iniParser[consoleType]

#sends msg given a socket
def sendMsg(socket, msg):
    msg = str.encode(msg)
    socket.sendall(msg)

def sendReading(name:str, reading:dict, socket: socket.socket):
    value = reading['value']
    time =  reading['time']
    
    msg = "#" + name + "/" + value + "/" + time
    #print(msg)
    sendMsg(socket, msg)
