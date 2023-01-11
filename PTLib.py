from configparser import ConfigParser
import time


import timing
import telemetry
import MCP3008
import socket
import spidev

class PT:
    #default values
    name = "\_x.x_/"
    offset = -1.0 
    slope = 0.0 #should stay at the default value if nothing changes

    #data values
    voltage = -1.0
    pressure = -1.0
    timeStamp = ""

    def __init__(self, name: str, ADC_init: MCP3008, channel_init: int, offset:float, slope:float):  
        self.name = name
        self.ADC = ADC_init
        self.channel = channel_init
        self.offset = offset
        self.slope = slope
        #self.socket = s

    def __str__(self) -> str: #debugging purposes
        return "[" + self.name + "]\nVoltage: " + str(self.voltage) + "\nPressure: " + str(self.pressure) + "\nOffset: " + str(self.offset) + "\nSlope: " + str(self.slope) + "\n"

    def getName(self):
        return self.name
    
    # def updateVoltage(self):
    #     self.voltage, _ = self.ADC.interogate(self.channel)
    #     self.timeStamp = timing.missionTime()
    #     return self.voltage
    
        #converts volts to PSI
    def voltsToPSI(self, voltage:float):
        return abs(self.slope*voltage+self.offset)

    def updatePressure(self):
        self.voltage, _ = self.ADC.interrogate(self.channel)
        #self.timeStamp = timing.missionTime()
        self.pressure = self.voltsToPSI(self.voltage)
        return self.pressure

def openSPI(chip, frequency):
    #opens an SPI channel
    spi = spidev.SpiDev()
    spi.open(0,chip)
    spi.max_speed_hz = frequency
    return spi

def parsePTini(PTfile: str):
    PTparser = ConfigParser()
    #will automatically closes the resource...sweet

    try:
        with open(PTfile) as f:
            PTparser.read_file(f)
    except IOError:
        print("ERROR: PTs_Config_FV.ini is missing")
        return None
    


    #PI commands ... ignore for now
    SPI0 = openSPI(0, 1000)
    SPI1 = openSPI(1, 1000)


    ADC0 = MCP3008(SPI0)
    ADC1 = MCP3008(SPI1)

    #dummy variables to run on PC
    # ADC0 = 0
    # ADC1 = 1

    PTs = dict()

    print("Loading", len(PTparser.sections()), "PT(s) from config file...")
    PTLoadCount = 0
    #Error checking done here
    for PTname in PTparser.sections():
        PTport = PTparser[PTname]['port']
        PTchannel = int(PTport[1])-1
        PTslope = float(PTparser[PTname]['slope'])
        PToffset = float(PTparser[PTname]['offset'])
        #hard coded values for ADC initializations 
        #should check for validity here
        if PTport[0] == 'A':
            PTs[PTname] = PT(PTname, ADC0, PTchannel, PToffset, PTslope)
        elif PTport[0] == 'B':
            PTs[PTname] = PT(PTname, ADC1, PTchannel, PToffset, PTslope)

        PTLoadCount += 1
        #print loading bar
    print("Successfully configured", PTLoadCount, "to the PI")
    return PTs

#refreshes all PT values sequentially -> not recommened for true multi-threading 
def refreshPTs(PT_dict: dict(), PT_freq_Hz: float):
    #The time between reading from PT(n) and PT(n+1)
    PT_period = 1/PT_freq_Hz #seconds
    while True:
        for PT_name in PT_dict:
            v1 = PT_dict[PT_name].updatePressure()
            #print(PT_dict[PT_name].getName() + " " + str(v1)) debug lines for value
            time.sleep(PT_period)

#PTperiod is the time between a PT reading...not individually code below will not work...
# def refreshPT(PTsensor:PT, PTperiod:float): #PTsensor should NOT be a string
#     while True: #guarantee case for now 
#         PTsensor.sendVoltage()
#         time.sleep(PTperiod)






