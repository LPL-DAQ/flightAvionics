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
import DRVLib

def main():
    timing.setRefTime(0,0,0)
    systemName = 'FV'
    print("Initializing PT Config...")
    PTs = PTLib.parsePTini("configFiles/PT_Config_FV.ini")
    print("Initializing TC Config...")
    TCs = TCLib.TC_Initialization("configFiles/TC_Config_FV.ini")
    print("Initializing SV Config...")
    SVs = SVLib.initialiseValves("configFiles/SV_Config_FV.ini")
    print("Initializing Reg Config ")
    REGs= DRVLib.initializeRegulators("configFiles/Reg_Config.ini")
    # iniData = telemetry.parseIniFile("configFiles/config.ini", "client")
    
    # clientFunc.clientSocket = findConnection(iniData["ip"],int(iniData["port"]))

    FVreadings = telemetry.Readings(PTs,TCs)
    FVstates = telemetry.valveStates(SVs)

    client = clientFunc.Client("configFiles/config.ini", FVreadings, FVstates, REGs)
    with concurrent.futures.ThreadPoolExecutor() as executor:
        #executor.submit(receiveNExecute, )
    
        executor.submit(PTLib.refreshPTs, PTs, client.getPTPoll()) #PT interogation thread
        executor.submit(TCLib.refreshTCs,TCs)
        executor.submit(client.runClient)
        executor.submit(client.receiveNExecute)

#runs FV_client
main()