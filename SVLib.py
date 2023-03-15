
import serial 
import time

from configparser import ConfigParser

def set_up_serial(port):
    """
    SUM: Sets up UART communication with Arduino
    AUG1: port(string of device port location look in /dev/ for mac and linux. 
         It is tty.(random stuff) or Device manager for windows com(#))
    RETURN: serial object
    """
    ser1 = serial.Serial(port,baudrate=9600, parity=serial.PARITY_NONE, timeout=1, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS)
    time.sleep(2)
    return ser1

ser = set_up_serial('/dev/ttyACM0')


def send_data(ser1, data_to_send):
    """
    SUM: sends data to the Arduino over UART
    AUG1: ser (serial object for device to send to) 
    AUG2: data_to_send (string of data to send)
    RETURN: None
    """
    send_data_list = list(data_to_send)
    print(send_data_list)
    for data_byte in send_data_list:
        ser1.write(data_byte.encode('ascii'))
        
def receive_data(ser,byte=False):

    data = ''

    if byte == True:
        data = ser.read()
    else:
        data = ser.readline()

    return data

class Valve():

    def __init__(self, serial_port:serial.Serial(),pin:str):
        self.pin = pin
        self.isON = False
        self.serial_port = serial_port
        self.sending = False
        
    #sets valve to normal state
    def powerON(self):
        msg = "#S"+self.pin+"/LOW__\n"
        send_data(self.serial_port,msg)
        self.isON = False

    #sets valve to closed state
    def powerOFF(self):
        msg = "#S"+self.pin+"/HIGH_\n"
        send_data(self.serial_port,msg)
        self.isON = True


def initialiseValves(configFile:str):

    

    SVsCfg = ConfigParser()
    SVsCfg.read(configFile)
    valves = dict()
    print("Initializing", len(SVsCfg.sections()), "valves...")
    for SV_name in SVsCfg.sections():
        SV_port = SVsCfg[SV_name]['port']
        valves[SV_name] = Valve(ser,SV_port)
        #might need an arduino poll to fully determine state
        #test all of them
        valves[SV_name].powerOFF()
        print("[", SV_name, "] has been initialized in its normal state", sep="")
    return valves


def timingSequence(timing):
    i=0
    print("SENDING TIMING")
    while(i<3):
        tmp = "00000"
        times = str(timing[i])
        print(tmp[:(5 - len(str(timing[i])))])
        new = tmp[:(5 - len(str(timing[i])))] + times
        print(new)
        msg = "#T0"+ str(i) + "/" + new + "\n"
        print(msg)
        send_data(ser,msg)
        time.sleep(1)
        i=i+1

def groundCommands(command):
    if command == "IGNITION":
        print("received ignition command")
        msg= "#GM1/SNDIT"
    if command == "ABORT":
        print("received abort command")
        msg= "#GM1/ABORT"
    send_data(ser,msg)


