from configparser import ConfigParser
import os
from datetime import datetime

import timing
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
        print("File rejected for the above reasons. Please fix and restart")
        
        exit()
    fileDict = dict()
    for i in parser.items(consoleType):
        fileDict[i[0]] = i[1]
    return fileDict


#checks file validity and outputs ip and port
def getIPAddress(filepath):
    valid = True
    ipAddress = verifyExistence(filepath, "address")
    
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
                print("ERROR: port ranges can only be from 1024 - 49151")
                valid = False
        except:
            valid = False
            print("ERROR: port is an invalid int")

    if not valid:
        print("File rejected for the above reasons. Please fix and restart")
        exit()
    else:
        return ip, port


#returns dict with necessary server values (savefile for now)
def verifyServerIni(filepath:str):
    parser = verifyExistence(filepath, "server")
    if parser == None:
        exit()
        #assumes the file is valid unless proven otherwise
    valid = True
    serverDict = dict()
    try:
        if "savefile" not in parser:
            valid = False
            print("ERROR: savefile not specified")
        else:
            if not os.path.exists("data"):
                print("WARNING: 'data' directory does not exist. Generating directory...")
                os.makedirs("data")
            date =  str(datetime.now().strftime("_%m-%d-%Y[%H:%M:%S].txt"))
            serverDict["fp"] = open("data/" + parser["savefile"] + date, 'w')
            serverDict["log"] = open("data/" + parser["savefile"]+ "log" + date, 'w')
    except:
        print("ERROR: Invalid file name.")
        valid = False
    serverDict["ip"], serverDict["port"] = getIPAddress(filepath)
    if serverDict["ip"] == None or serverDict["port"] == None:
        valid = False
    if not valid:
        print("File rejected for the above reasons. Please fix and restart")
        exit()
    return serverDict

#client ini file verification
def verifyClientIni(filepath:str):
    parser = verifyExistence(filepath, "client")
    if parser == None:
        exit()
    valid = True
    clientDict = dict()
    if "pt_poll" not in parser:
        valid = False
    else:
        try:
            parsedVal = float(parser["pt_poll"])
            if parsedVal == 0: #divide by 0 error
                clientDict["pt_poll"] = 0
            else: #converts freq to period
                clientDict["pt_poll"] = 1.0 / parsedVal 
        except:
            print("ERROR: [pt_poll] must be a float")
            valid = False
    if "sendrate" not in parser:
        valid = False
    else:
        try:
            parsedVal = float(parser["sendrate"])
            if parsedVal == 0: #divide by 0 error
                clientDict["sendrate"] = 0
            else: #converts freq to period
                clientDict["sendrate"] = 1.0 / parsedVal
        except Exception as e:
            print(e)
            print("ERROR: [sendrate] must be a float")
            valid = False
    if not valid:
        print("File rejected for the above reasons. Please fix and restart")
        exit()
    return clientDict
