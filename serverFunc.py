import time

import queue
import readings
import timing

commandQ = queue.Queue()
readings = readings.Readings({},{},{})
armedValves: dict = {}

def appendCommand(inReadings):
    for valve in armedValves:
        if armedValves[valve]=='ARMED':
            
            
            reading = inReadings.readings[valve]
            state = reading['value']

            if state == "OPENED_":
                #inReadings.push(valve,"CLOSES","00000")
                msg = "#" + valve + "/" + "CLOSE" + "/" + timing.missionTime() 
                #inReadings.push(valve,"CLOSED",time)
                print("Set",valve,"to CLOSED")
            else:
                #inReadings.push(valve,"OPENED","00000")
                msg = "#" + valve + "/" + "OPEN_" + "/" + timing.missionTime()
                #print("Set",valve,"to OPENED")
                inReadings.update(valve,"OPENED",time)

            commandQ.append(msg)