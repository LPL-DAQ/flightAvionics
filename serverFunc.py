import time
import socket
import threading

import queue
import timing
import telemetry

commandQ = queue.Queue()
dataReadings = dict()
armedValves = dict()
SVdata = dict()
serverSocket = None
connected = False

#returns dict with necessary server values (savefile for now)
def verifyServerIni(filepath:str, consoleType:str):
    parser = telemetry.verifyExistence(filepath, consoleType)
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
            serverDict["fp"] = open("data/" + parser["savefile"] + str(timing.missionTime()), 'w')
    except:
        print("ERROR: Invalid file name or data file is missing")
        valid = False
    serverDict["ip"], serverDict["port"] = telemetry.getIPAddress(filepath)
    if serverDict["ip"] == None or serverDict["port"] == None:
        valid = False
    if not valid:
        exit()
    return serverDict
    

#adds a valve command to the client...needs a verification and client feedback msg
def appendCommand(SVstates, armedValues):
    for valve in armedValues:
        if armedValues[valve]=='ARMED':
            state = SVstates[valve]
            if state == "OPENED_":
                msg = "#" + valve + "/" + "CLOSE" + "/" + timing.missionTime() 
                SVstates[valve] = "CLOSED_"
                print("Set",valve,"to CLOSED")
            else:
                msg = "#" + valve + "/" + "OPEN_" + "/" + timing.missionTime()
                SVstates[valve] = "OPENED_"
                print("Set", valve, "to OPENED")
            commandQ.put(msg)

#server receives a message (data msg for now)
def receiveData(socket, dataReadings:telemetry.Readings, fp):
    msg = socket.recv(1024)
    if msg:
        msg = msg.decode("utf-8")
    else: #not sure if this will ever run...
        socket.close
        print("Connection Lost")
        raise Exception("Connection Lost")
    data = msg.split("#")

    try:
        while data:
            if len(data[0]) == 24:

                received_reading = data[0].split("/")

                name = received_reading[0]
                value = received_reading[1]
                time = received_reading[2]
                if name[:2] == "SV":
                    SVdata[name] = value
                else:
                    dataReadings[name] = value
                #GUI update func (readings class not necessary...dict will suffice)
                #dataReadings.update(name,value,time)
                
                #write to file func
                #need to change mission time ltr
                fp.write(name + " " + value + " " + timing.missionTime() + "\n")
                
                #print to console
                print(name + " " + value + " " + timing.missionTime(), flush = True)
                
            data.remove(data[0])
    except Exception as e:
        print(e)
        print('Data processing error occured')
