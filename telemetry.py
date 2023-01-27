import socket
from configparser import ConfigParser

#class for all sensor HW
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

    #returns the data based off of sensor name
    def getData(self, name:str):
        return self.readings[name]
    
    #updates the value of a sensor 
    def update(self,name:str,value:str,time:str):
        new_reading = dict()
        new_reading['value']= value
        new_reading['time']= time
        new_reading['type']= name[0:2]
        self.readings[name] = new_reading
        
#class for all control HW
class valveStates:
    def __init__(self, SV_dict:dict) -> None:
        self.SVs = SV_dict
        self.states = dict()

    #updates the state of a sensor
    def update(self,name:str,value:str,time:str):
        new_reading = dict()
        new_reading['value']= value
        new_reading['time']= time
        new_reading['type']= name[0:2]
        self.states[name] = new_reading
    
    #execute valve command...needs error check
    def execute(self,name:str,value:str,time:str):
        if value == 'OPEN_':
            self.SVs[name].openValve()
            self.update(name,'OPENED_',time)
        elif value == 'CLOSE':
            self.SVs[name].closeValve()
            self.update(name,'CLOSED_',time)


#returns a dict of the consoleType members if the file is valid and None if the file does not exist
def verifyExistence(filepath:str, consoleType:str) -> dict:
    parser = ConfigParser()
    try:
        with open(filepath) as f:
            parser.read_file(f)
    except IOError:
        print("ERROR:", filepath, "not found")
        exit()
    #parser = parser.sections()
    if consoleType not in parser.sections():
        print("ERROR: [", consoleType, "] is missing from ", filepath, sep = "")
        exit()
    fileDict = dict()
    for i in parser.items(consoleType):
        fileDict[i[0]] = i[1]
    return fileDict

#checks file validity and outputs ip and port
def getIPAddress(filepath):
    valid = True
    ipAddress = verifyExistence(filepath, "address")
    if ipAddress == None:
        return None, None
    
    if "ip" not in ipAddress:
        valid = False
        print("ERROR: ip not specified in [address] section")
    else:
        ip = ipAddress["ip"]
    if "port" not in ipAddress:
        valid = False
        print("ERROR: port is not specifed in the [address] section")
    else:
        try:
            port = int(ipAddress["port"])
            if port < 1024 or port >49151:
                print("ERROR: Port ranges can only be from 1024 - 49151")
                valid = False
        except:
            valid = False
            print("ERROR: port is an invalid int")

    if not valid:
        return None, None
    else:
        return ip, port

#sends msg given a socket
def sendMsg(socket, msg):
    msg = str.encode(msg)
    socket.sendall(msg)

def sendReading(name:str, reading:dict, socket: socket.socket):
    value = reading['value']
    time =  reading['time']
    
    msg = "#" + name + "/" + value + "/" + time
    
    sendMsg(socket, msg)
