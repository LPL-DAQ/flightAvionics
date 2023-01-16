import time
import socket

import queue
import timing
import telemetry

commandQ = queue.Queue()
dataReadings = dict()
armedValves = dict()
SVdata = dict()
serverSocket = None
connected = False

def appendCommand(SVstates, armedValues):
    for valve in armedValues:
        if armedValues[valve]=='ARMED':

            state = SVstates[valve]

            if state == "OPENED_":
                #inReadings.push(valve,"CLOSES","00000")
                msg = "#" + valve + "/" + "CLOSE" + "/" + timing.missionTime() 
                SVstates[valve] = "CLOSED_"
                print("Set",valve,"to CLOSED")
            else:
                #inReadings.push(valve,"OPENED","00000")
                msg = "#" + valve + "/" + "OPEN_" + "/" + timing.missionTime()
                SVstates[valve] = "OPENED_"
                print("Set", valve, "to OPENED")
            commandQ.put(msg)


def receiveData(socket, dataReadings:telemetry.Readings, fp):
    msg = socket.recv(1024)
    if msg:
        msg = msg.decode("utf-8")
    else: #not sure if this will ever run...
        socket.close
        print("Connection Lost")
        raise Exception("Connection Lost")
    data = msg.split("#")
    #print("msg = ",msg)

    try:
        while data:
            if len(data[0]) == 24:
                #print("data= ",data[0])
                
                received_reading = data[0].split("/")

                name = received_reading[0]
                value = received_reading[1]
                time = received_reading[2]
                if name[:2] == "SV":
                    SVdata[name] = value
                else:
                    dataReadings[name] = value
                #GUI update func
                #dataReadings.update(name,value,time)
                
                #write to file func
                #need to change mission time ltr
                fp.write(name + " " + value + " " + timing.missionTime() + "\n")
                #print to console
                print(name + " " + value + " " + timing.missionTime(), flush = True)

                #if name =='PTH001':
                #print ("Time: " + time)
                #logStamp = timing.getTimeDiffInSeconds(originTime, time)
                #print (name + " " + value + " " + timing.missionTime() , file = filename, flush = True)
                #print(data[0], file = sourceFile, flush=True)

            data.remove(data[0])
    except Exception as e:
        print(e)
        print('Data processing error occured')
