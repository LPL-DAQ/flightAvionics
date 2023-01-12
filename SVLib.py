
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
    ser = serial.Serial(port,baudrate=9600, parity=serial.PARITY_NONE, timeout=1, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS)
    time.sleep(2)
    return ser


def send_data(ser, data_to_send):
    """
    SUM: sends data to the Arduino over UART
    AUG1: ser (serial object for device to send to) 
    AUG2: data_to_send (string of data to send)
    RETURN: None
    """
    send_data_list = list(data_to_send)
    for data_byte in send_data_list:
        ser.write(data_byte.encode('ascii'))
        
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
        self.isOpen = False
        self.serial_port = serial_port
        

    def openValve(self):
        msg = "#S"+self.pin+"/LOW__\n"
        send_data(self.serial_port,msg)
        print(msg)
        self.isOpen = True

    def closeValve(self):
        msg = "#S"+self.pin+"/HIGH_\n"
        send_data(self.serial_port,msg)
        print(msg)
        self.isOpen = False


def initialiseValves(configFile:str):

    ser = set_up_serial('/dev/ttyACM0')

    SVsCfg = ConfigParser()
    SVsCfg.read(configFile)
    valves = dict()

    for SV_name in SVsCfg.sections():
        SV_port = SVsCfg[SV_name]['port']
        valves[SV_name] = Valve(ser,SV_port)

    return valves