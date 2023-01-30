import concurrent.futures
import socket
import threading

import time

import telemetry
import timing
import PTLib
import TCLib
import SVLib
import clientFunc

def main():
    timing.setRefTime(0,0,0)
    systemName = 'FV'

    PTs = PTLib.parsePTini("configFiles/PT_Config_FV.ini")
    TCs = TCLib.TC_Initialization("configFiles/TC_Config_FV.ini")
    SVs = SVLib.initialiseValves("configFiles/SV_Config_FV.ini")
    # iniData = telemetry.parseIniFile("configFiles/config.ini", "client")
    
    # clientFunc.clientSocket = findConnection(iniData["ip"],int(iniData["port"]))

    FVreadings = telemetry.Readings(PTs,TCs)
    FVstates = telemetry.valveStates(SVs)

    client = clientFunc.Client("configFiles/config.ini", FVreadings, FVstates)
    with concurrent.futures.ThreadPoolExecutor() as executor:
        #executor.submit(receiveNExecute, )
    
        executor.submit(PTLib.refreshPTs, PTs, client.getPTPoll()) #PT interogation thread
        executor.submit(TCLib.refreshTCs,TCs)
        executor.submit(client.runClient)
        executor.submit(client.receiveNExecute)

#runs FV_client
main()