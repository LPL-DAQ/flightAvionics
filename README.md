```
            ===============================================================================
                              _   _ ____   ____   _     _             _     _  
                             | | | / ___| / ___| | |   (_) __ _ _   _(_) __| | 
                             | | | \___ \| |     | |   | |/ _` | | | | |/ _` | 
                             | |_| |___) | |___  | |___| | (_| | |_| | | (_| | 
                              \___/|____/ \____| |_____|_|\__, |\__,_|_|\__,_| 
                             |  _ \ _ __ ___  _ __  _   _| |_|_(_) ___  _ __   
                             | |_) | '__/ _ \| '_ \| | | | / __| |/ _ \| '_ \  
                             |  __/| | | (_) | |_) | |_| | \__ \ | (_) | | | | 
                             |_|   |_|  \___/| .__/_\__,_|_|___/_|\___/|_| |_| 
                             | |    __ _| |__|_||  _ \  / \  / _ \             
                             | |   / _` | '_ \  | | | |/ _ \| | | |            
                             | |__| (_| | |_) | | |_| / ___ \ |_| |            
                             |_____\__,_|_.__/  |____/_/   \_\__\_\ 
            ==============================================================================
```
 
 Flight Vehicle DAQ Code Documentation
 -

I'm writing this in hopes that the code written here is both readible and usable for anyone-- even those without coding or DAQ knowledge-- in lab to use. For those who do have coding experience, my hope is that you will be able improve both this code's functionality and efficiency. I have also provided additional code snippets that can help with repetitive functions. 

~~For the love of god please do not make me have to error check for user inputs~~ <br>
looks like I have to hahaah...fuck

### Config Files
Config files will all be located in the config folder. The file names are hardcoded into the DAQ code and should **NOT** have their name changed unless you know what you are doing. 
#### config.ini
This file currentally has 3 header sections that allow for customization on the server and client side. Note* Omitting a value or submitting an invalid one will result in error:
- [address]
    - ip (str) 
        - see "DAQ Startup Procedure" to find the IP of your system. 
        - An invalid ip will prevent the system from running
    - port (int) 
        - select a port for the socket to bind to. 
        - Must be between 1024 and 49151 otherwise an error is printed
- [server]
    - savefile (str) specifies the name of the file where the data should be stored server side. 
        -Will be in the form: <saveFile><timestamp>.txt in the folder labeled "data"
- [client]
    - pt_poll (float) 
        - Sets the polling rate of the PTs in Hz 
    - sendrate (float)
        - Sets the send rate of the client in Hz

#### PT_Config_FV.ini
This file contains a header for each PT and has the following values:
- port (str)
    - Specifies the port used in the DAQ
- slope (float)
    - Used for voltage to value conversion
- offset (float)
    - Used for voltage to value conversion
- unit (str)
    - Units for PT readings (psi)
- max (int)
    - Max pressure the PT is rated for
- system (str)
    - Specifies which system the PT is configured for (FV)
    
#### TC_Config_FV.ini
This file contains a header for each TC and has the following values:
- port
    - Specifies the port used in the DAQ
- offset
    - Used for voltage to value conversion
- offset_units
    - Specifies the unit of the reading
- temp_units
    - Specifies the unit of the reading
- system (str)
    - Specifies which system the PT is configured for (FV)
    
#### SV_Config_FV.ini
This file contains a header for eaach SV and has the following values:
- port 
    - Specifies the port used in the DAQ
    
#### TC_Port_ID.ini
ID values for TC
- id
    - ID hash for TC validation

### Networking Message (Backend)
These are the possible messages that are sent between the client and server. Users will never explicitly see these messages and only serve as communication between the client and the server. Every message will start with "#" and be divided by "/" 
#### Server side
```
- #KILL 
    Sends a command setting all valves to normal state
- #<valveName>/<proposedChange>
    Sets a valve to a proposed state (ON/OFF)
```
#### Client side
```
- #<sensorName>/<value>/<timestamp>
    Sends a message with the sensorName, value, and timestamp
- #<valveName>/<newChange>
    Sends a message that confirms the proposed change
```
        

Additional Programs
-

Things to Implement:
 - PT, TC, and SV file validity
 - Abort sequence
 - Get custom value timings working
 - Valve timing feedback messages
 - console thread
 - launch sequence
 
Resources
-
 - DAQ Startup Procedure
 - Github Guide for DAQ

Notes
-
For hooking up wires (from left to right) follow this riddle: <br>
    Red touch yellow, kill a fellow,<br>
    Red touch black, won't fry jack, <br>
    Yellow touch red and it'll be dead <br>
Solution: Red (+) Black (-) Yellow (Data)







