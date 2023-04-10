import RPi.GPIO as GPIO
import time
from time import sleep
from configparser import ConfigParser


#This code is to control the DRV8825 Driver for Stepper Motors (regulators)

class DRV8825():

    def __init__(self, _direction_pin, _step_pin):
        print("Initializing Regulator")
        #define GPIO pins on PI
        self.direction_pin=int(_direction_pin)# Direction (DIR) GPIO Pin
        self.step_pin = int(_step_pin) # STEP GPIO Pin
        #self.MODE_pins= (14, 15, 18) #Step Mode GPIO pins
        #self.gpiopins=[self.direction_pin, self.step_pin, self.MODE, self.sensor]

        #constants
        self.wait=0.004
        self.initdelay=0.05
        self.steptype="FULL"

        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.direction_pin, GPIO.OUT) #set direciton pin as output
        GPIO.setup(self.step_pin, GPIO.OUT) #set step pin as output
        #GPIO.setup(self.MODE_pins, GPIO.OUT) #set Mode pins as output

        GPIO.setwarnings(True)
        self.stop_motor = False

        self.RESOLUTION ={ 'FULL': (0,0,0),  #based on the DRV8825 datasheet
                    'HALF': (1,0,0),
                    '1/4': (0,1,0),
                    '1/8':(1,1,0),
                    '1/16':(0,0,1),
                    '1/32':(1,0,1)}


    def StopMotorInterrupt(Exception):
        """ Stop the motor """
        pass

    def motor_stop(self):
            """ Stop the motor """
            self.stop_motor = True

    def motor_run(self, steps:int, DIR:int ):
        #DIR: 1 for clockwise and 0 for counterclockwise
        #steptype: 'FULL', 'HALF', '1/4', '1/8', '1/16', '1/32'

        if steps < 0:
                print("Error: Step number must be greater than 0")
                quit()
        try: 
            print("Running Motor")
            GPIO.output(self.direction_pin,DIR)
            #GPIO.output(self.MODE_pins, self.RESOLUTION[steptype])
            time.sleep(self.initdelay)

            for x in range(steps):
                if self.stop_motor:
                    raise self.StopMotorInterrupt
                else:
                    GPIO.output(self.step_pin,GPIO.HIGH)
                    sleep(self.wait)
                    GPIO.output(self.step_pin, GPIO.LOW)
                    sleep(self.wait)
                    print("step:", x)


        except self.StopMotorInterrupt:
            print("Stop Motor Interrupt")


def initializeRegulators(configFile:str):
    RegCfg = ConfigParser()
    RegCfg.read(configFile)
    regulators= dict()
    print("Initializing", len(RegCfg.sections()), "pressure regulators...")
    for Reg_name in RegCfg.sections():
        direction_pin=  RegCfg[Reg_name]['direction_pin']
        step_pin= RegCfg[Reg_name]['step_pin']
        regulators[Reg_name]= DRV8825(direction_pin, step_pin)
    return regulators



                




