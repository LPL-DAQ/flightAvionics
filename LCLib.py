#!/usr/bin/env 

import time
import socket
import spidev
from configparser import ConfigParser
import logging


# import GPIO
import RPi.GPIO as GPIO      
# import the class HX711         
from hx711 import HX711    





#Defining the Load Cell Class
class LC:
    #physical values
    reading= -1.0
    pounds= -1.0
    timeStamp= " "

    #linear fit variables
    offset = -107899
    slope = 1

    def __init__(self, ADC_init: HX711):  
        # the ADC chip the LC is connected to
        self.ADC = ADC_init
        # the channel the LC is connected to on the ADC val=0...7


    # Assumes voltage is given in mV
    def __getWeight(self,reading):
        #ADCgain = ADC._gain_channel_A
        #excitationVoltage = 5 #volts <- already accounted for in the vout signal
        pounds = abs(self.slope*reading+ self.offset)
        
        return pounds


    def getPounds(self):
        self.reading = self.ADC.get_data_mean()
        #print(self.reading)
        self.pounds = self.__getWeight(self.reading)
        print(self.pounds)
        #self.timeStamp = timing.missionTime()


    

        #print(self.channel,':',self.voltage)
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

        if LC_port[0] == 'A':
            LCs[LC_name] = LC(ADC)
        #elif LC_port[0] == 'B':
            #LCs[LC_name] = LC(ADC1,LC_channel)

        LCs[LC_name].slope = float(LCsCfg[LC_name]['slope'])
        LCs[LC_name].offset = float(LCsCfg[LC_name]['offset'])
        
        

        print("[{}] has been added successfully".format(LC_name))

    return LCs
    

def refreshLCs(LC_dict: dict(), LC_freq_Hz: float):
    #The time between reading from LC(n) and LC(n+1)
    LC_period = 1/LC_freq_Hz #seconds
    while True:
        for LC_name in LC_dict:
            pounds= LC_dict[LC_name].getPounds()
            #p1 = LC_dict[LC_name].pounds
            #v1 = LC_dict[LC_name].voltage
            #formatedText = "[{}]: {:0>7.2f} Pounds | {:0>4.2f} V".format(LC_name,p1,v1)
            #print(formatedText)
            time.sleep(LC_period)