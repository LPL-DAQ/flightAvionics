import socket


#class for all sensor HW
class Readings:
    def __init__(self,PT_dict:dict,TC_dict:dict):
        self.PTs = PT_dict
        self.TCs = TC_dict
        self.readings = dict()
        self.refreshAll()
        
    #updates the value and timestamp for each value sequentially (HW limitation)
    def refreshAll(self):
        for PT_name in self.PTs:
            new_reading = dict()
            new_reading['value']= "{:0>7.2f}".format(self.PTs[PT_name].pressure)
            new_reading['time']= self.PTs[PT_name].timeStamp
            new_reading['type']= 'PT'
            self.readings[PT_name] = new_reading

        for TC_name in self.TCs:
            new_reading = dict()
            temp = self.TCs[TC_name].temperature.get('k')
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
    def update(self,name:str,value:str):
        self.states[name] = value
    
    #execute valve command...needs error check
    def execute(self,name:str,value:str):
        if value == 'ON':
            self.SVs[name].powerON()
            self.update(name,'ON')
        elif value == 'OFF':
            self.SVs[name].powerOFF()
            self.update(name,'OFF')
        else:
            print("DID NOTHING:", value)

    def getValveState(self, name:str):
        if name not in self.states:
            print("WARNING: Unknown Valve name")
            return None
        return self.states[name]

#sends msg given a socket
def sendMsg(socket, msg):
    msg = str.encode(msg)
    socket.sendall(msg)

#sends a reading to a socket
def sendReading(name:str, reading:dict, socket: socket.socket):
    value = reading['value']
    time =  reading['time']
    
    msg = "#" + name + "/" + value + "/" + time
    
    sendMsg(socket, msg)


