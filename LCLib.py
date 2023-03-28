import time
import socket
import spidev
from configparser import ConfigParser
import logging
import timing
import RPi.GPIO as GPIO      
from hx711 import HX711    





#Defining the Load Cell Class
class LC:
    #physical values
    reading= -1.0
    pounds= -1.0
    timeStamp= " "
    voltage= -1.0

    #linear fit variables
    offset = 0
    slope = 1

    def __init__(self, ADC_init: HX711, offset, slope):  
        # the ADC chip the LC is connected to
        self.ADC = ADC_init
        self.offset= offset
        self.slope = slope
        # the channel the LC is connected to on the ADC val=0...7


    # Assumes voltage is given in mV
    def __getWeight(self,voltage):
        pounds = abs(self.slope*voltage+ self.offset)
        
        return pounds
    
    def __countsToVolts(self, reading):
        volts= 0.976858537*reading/(2^23) #converts from ADC counts to voltage based on 24 bit ADC (-1 for the sign)

        return volts

    def getPounds(self):
        self.reading = self.ADC.get_data_mean()
        self.voltage= self.__countsToVolts(self.reading)
        self.pounds = self.__getWeight(self.voltage)
        self.timeStamp= timing.missionTime()
        return self.pounds



def LCs_init(cfg_file_name: str):
    #Open LC config file
    LCsCfg = ConfigParser()
    LCsCfg.read(cfg_file_name)

    # instantiate object of HX711 class
    ADC = HX711(dout_pin=21, pd_sck_pin=20, gain_channel_A=128, select_channel='A')

    #Create a LC dictionary
    LCs = dict()
    
    print('Adding LCs from cfg')

    #Generate LC Objects from the cfg file and store them in the LC dictionary
    for LC_name in LCsCfg.sections():
        LC_port = LCsCfg[LC_name]['port'] 
        slope = float(LCsCfg[LC_name]['slope'])
        offset = float(LCsCfg[LC_name]['offset'])

        if LC_port[0] == 'A':
            LCs[LC_name] = LC(ADC, slope, offset)
        #elif LC_port[0] == 'B':
            #LCs[LC_name] = LC(ADC1,LC_channel)

        
        
        

        print("[{}] has been added successfully".format(LC_name))

    return LCs
    

def refreshLCs(LC_dict: dict()):
    #The time between reading from LC(n) and LC(n+1)
    LC_freq_Hz= 10
    LC_period = 1/LC_freq_Hz #seconds
    while True:
        for LC_name in LC_dict:
            pounds= LC_dict[LC_name].getPounds()
            print(pounds) #debugging
            time.sleep(LC_period)