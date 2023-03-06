import os
import time
import glob
import timing
import subprocess
import time
from configparser import ConfigParser


# Initialize 1-wire protocol drivers
os.system('modprobe w1-gpio')

#needs debugging
os.system('modprobe w1-therm')

class Temperature():
    
    def __init__(self,val:float,unit:str):
        self.values = {}
        self.push(val,unit)
        
    def push(self,val:float,unit:str):
        if unit == 'c':
            self.values[unit] = val
            self.values['f'] = self.__c2f(self.values['c'])
            self.values['k'] = self.__c2k(self.values['c'])
        elif unit == 'f':
            self.values[unit] = val
            self.values['c'] = self.__f2c(self.values['f'])
            self.values['k'] = self.__c2k(self.values['c'])
        elif unit == 'k':
            self.values[unit] = val
            self.values['c'] = self.__k2c(self.values['k'])
            self.values['f'] = self.__c2f(self.values['c'])

        else :
            print('ERROR: Wrong unit')

    def get(self,unit:str):
        if unit == 'c':
            return self.values['c']
            
        elif unit == 'f':
            return self.values['f']

        elif unit == 'k':
            return self.values['k']

        else :
            print('ERROR: Wrong unit')


    def __c2f(self,val):
        return 9/5*val+32

    def __c2k(self,val):
        return val + 273.15

    def __f2c(self,val):
        return 5/9*(val-32)

    def __k2c(self,val):
        return val - 273.15



# Thermocouple class for reading temperatures and retriving IC ID value.
class TC():
    """Thermocouple readings over w1 communications protocol."""

    def __init__(self, id: str(), offset:Temperature, ref:Temperature):
        self.id = id
        self.offset = offset # Has to be fahrenheit input
        self.temperature = Temperature(0,'c')
        self.timeStamp = timing.missionTime()
        self.ref = ref
        

    def __tempFilePath(self):
        """Returns string file path of slave file of chose sensor by index integer input."""
        sensor_master_directory = '/sys/bus/w1/devices/w1_bus_master1/'
        sensor_slave_file = sensor_master_directory + '3b-' + self.id + '/w1_slave'
        return sensor_slave_file
        
    def __rawTemperature(self):
        """Opens chosen sensor slave file, reads contents,
         and outputs list of contents given slave file path as string input."""
        slave_file_open = open(self.__tempFilePath(), 'r')
        slave_file_read = slave_file_open.readlines()
        slave_file_open.close()
        return slave_file_read

    def getTemperature(self):
        """Extracts raw temperature data from slave file, then computes temperature reading
        in celsius by default, fahrenheit and kelvin are optional, 
        given slave file path contents as string input."""
        slave_file_contents = self.__rawTemperature()

        # Checks if slave file content contains 'YES" to confirm sensor is functioning properly.
        while slave_file_contents[0].strip()[-3:] != 'YES':
            print("Error reading temperature, re-attempt in 2 seconds.")
            time.sleep(2)
            slave_file_contents = self.__rawTemperature()

        # Returns index of where 't=' beings in contents of slave file.
        temperature_index = slave_file_contents[1].find('t=')

        # Checks if 't=' exists in slave file contents before computing and retunring temperature reading.
        if temperature_index != -1:
            
            raw_temperature = slave_file_contents[1].strip()[temperature_index + 2:]
            self.timeStamp = timing.missionTime()
            c_temp = float(raw_temperature) / 1000.0 + self.offset.get('c') - self.ref.get('c')
            #print(c_temp)
            self.temperature.push(c_temp ,'c')
            
        # Warning if unable to retrieve temperature data.
        else:
            print("Unable to get temperature reading at" + str(self.sensor_index) + ".")

        
        


def __convertTemp(offset: float(), offset_units: str()):
    """Converts any unit into fahrenheit."""
    if offset_units == 'f':
        return offset

    elif offset_units == 'c':
        return offset * (9.0 / 5.0) + 32.0
        
    elif offset_units == 'k':
        return (offset - 273.15) * (9.0 / 5.0) + 32.0


# Calls data from TC_Config_FV.ini to associate TC index in sensor list generated by glob library
# to its prescribed name in P&ID. Outputs a key-list dictionary, key is the perscribed name
# and value is the TC Class and offset.
def TC_Initialization(config_File_Name: str()):
    TC_config = ConfigParser()
    TC_port_ID = ConfigParser()

    TC_config.read(config_File_Name)
    TC_port_ID.read('configFiles/TC_Port_ID.ini')

    TC_init_dict = dict()

    print("Compiling TCs from configuration file")

    for TC_name in TC_config.sections():
        offset = float(TC_config[TC_name]['offset'])
        offset_units = TC_config[TC_name]['offset_units']
        temp_units = TC_config[TC_name]['temp_units']
        port = TC_config[TC_name]['port']
        ID = TC_port_ID[port]['id']
        #validity check required
        #offset = __convertTemp(offset, offset_units)
        #print(offset)
        # TC_init_dict[TC_name] = TC(ID, offset, temp_units)
        #temp = Temperature(offset,offset_units)
        
        TC_init_dict[TC_name] = TC(ID, Temperature(offset,offset_units),Temperature(0,offset_units))
        #add loading bar
        print("[{}] has been successfully intialized.".format(TC_name))

    return TC_init_dict


def convertTime(convert_time: int()):
    sensor_master_directory = '/sys/bus/w1/devices/w1_bus_master1/'
    sensor_folder = glob.glob(sensor_master_directory + '3b*')

    for sensor in range(0, len(sensor_folder)):
        convert_time_file = sensor_folder[sensor] + '/conv_time'
        echo_command = "echo {} > {}".format(convert_time, convert_time_file)
        subprocess.Popen(['sudo', 'sh', '-c', echo_command])


convertTime(15)


def refreshTCs(TC_dict: dict()):
    
    while True:
        for sensor in TC_dict:
            #rint('yoooooo')
            TC_dict[sensor].getTemperature()
            #output = "[{}]: {:0>7.2f} F".format(sensor, temp_reading)
            #print(output)
            #print('yoooooo222')

