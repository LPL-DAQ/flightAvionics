import concurrent.futures
import socket

import time

import telemetry
import readings
import timing
import PTLib
import TCLib
import SVLib

def client_IO(s:socket.socket,frequency:float,clientReadings:readings.Readings):
    period = 1/frequency
    print("Starting data stream...")
    while True:
        clientReadings.refreshAll()
        try:
            for sensorName in clientReadings.readings:
                readings.sendReading(sensorName, clientReadings.readings[sensorName], s)
                time.sleep(period)
        except:
            s.close()
            print("WARNING: Client has lost connection to the server")
            break


def client_coms(server: dict, frequency:float, clientReadings: readings.Readings):
    while True:
        try:
            print("Looking for server")
            #if this does not work add setblocking to it
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((server["IP"], server["port"]))
            s.setblocking(0) #might change to settimeout
            print("Connection established with server. IP:{}    port:{}".format(server['IP'],server['port']))
            client_IO(s, frequency, clientReadings)
        except:
            print("Could not connect...retrying in 5 seconds")
            time.sleep(5)

def main():
    timing.setRefTime(0,0,0)

    systemName = 'FV'

    PTs = PTLib.PTs_init("configFiles/PTs_Config_FV.ini")
    TCs = TCLib.TC_Initialization("configFiles/TC_Config_FV.ini")
    SVs = SVLib.initialiseValves("configFiles/SV_Config_FV.ini")

    iniVals = telemetry.parseIniFile("configFiles/config.ini", "PI")

    server = {'IP':iniVals["ip"],'port':iniVals["port"]}


    #print("'" + telemetry.getIP() + "'")


    FV_readings = readings.Readings(PTs,TCs,SVs)

    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.submit(PTLib.refreshPTs,PTs, iniVals["PTpoll"]) #PT interogation thread
        executor.submit(TCLib.refreshTCs,TCs)
        executor.submit(client_coms,server,iniVals["sendRate"],FV_readings)



#runs FV_client
main()