import concurrent.futures
import socket
import threading

import time

import telemetry
import timing
import PTLib
import TCLib
import SVLib

connect = False
masterSocket = None

def receiveNExecute(s:socket.socket, lock:threading.Lock, states):
    while True:
        if connect:
            msg = s.recv(1024).decode("utf-8")
            data = msg.split("#")
            while data:
                if len(data[0]) == 22:
                
                    received_reading = data[0].split("/")

                    name = received_reading[0]
                    value = received_reading[1]
                    time = received_reading[2]

                    print(received_reading)
                    states.execute(name,value,time)

                    #confirmation command here using lock

                else:
                    print("WARNING: Corrupted command")
                data.remove(data[0])

def findConnection(ip:str, port:int):
    while True:
        try:
            print("Looking for server")
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((ip, port))
            s.setblocking(0) #might change to settimeout
            connect = True
            print("Connection established with server. IP:{}    port:{}".format(ip , port))
            return s
        except:
            print("Could not connect...retrying in 5 seconds")
            time.sleep(5)


def clientIO(s:socket.socket,frequency:float,clientReadings:telemetry.Readings):
    period = 1/frequency
    print("Starting data stream...")
    while True:
        clientReadings.refreshAll()
        try:
            for sensorName in clientReadings.readings:
                
                telemetry.sendReading(sensorName, clientReadings.readings[sensorName], s)
                time.sleep(period)
        except Exception as e:
            #remove this ltr
            print(e)
            connect = False
            s.close()
            print("WARNING: Client has lost connection to the server")
            break

def runClient(s:socket, ip:str, port:int, frequency:float, clientReadings: telemetry.Readings):
    while True:
        try:
            clientIO(s, frequency, clientReadings)
            s = findConnection(ip, port)
        except:
            print("something unintended occurred")

def main():
    timing.setRefTime(0,0,0)

    systemName = 'FV'

    PTs = PTLib.parsePTini("configFiles/PTs_Config_FV.ini")
    TCs = TCLib.TC_Initialization("configFiles/TC_Config_FV.ini")
    SVs = SVLib.initialiseValves("configFiles/SV_Config_FV.ini")

    iniData = telemetry.parseIniFile("configFiles/config.ini", "PI")
    lock = threading.Lock()
    masterSocket = findConnection(iniData["ip"],int(iniData["port"]))
    #client = {'IP':iniData["ip"],'port':int(iniData["port"])}


    #print("'" + telemetry.getIP() + "'")


    FVreadings = telemetry.Readings(PTs,TCs)
    FVstates = telemetry.valveStates(SVs)

    with concurrent.futures.ThreadPoolExecutor() as executor:
        #executor.submit(receiveNExecute, )
    
        executor.submit(PTLib.refreshPTs, PTs, float(iniData["PTpoll"])) #PT interogation thread
        executor.submit(TCLib.refreshTCs,TCs)
        executor.submit(runClient, masterSocket, iniData["ip"],int(iniData["port"]), float(iniData["sendRate"]),FVreadings)
        executor.submit(receiveNExecute, masterSocket, FVstates)

#runs FV_client
main()