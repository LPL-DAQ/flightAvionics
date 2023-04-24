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

def mockConsole(client:clientFunc.Client):
    while True:
        userIn = input(">")
        data = userIn.split(" ")
        if len(data) == 3 and data[0] == "SEND":
            try:
                times = int(data[2])
            except Exception as e:
                print("ERROR: <times> must be an int")
            for i in range(0, times):
                telemetry.sendMsg(client.getSocket(), data[1])
            print("JOB DONE")
            
def mockReceiver():
    while True:


def main():
    timing.setRefTime(0,0,0)
    #systemName = 'FV' #unused for now...

    #initialization using the ini files in the config folder
    print("Initializing PT Config...")
    PTs = PTLib.parsePTini("configFiles/PT_Config_FV.ini")
    print("Initializing TC Config...")
    TCs = TCLib.TC_Initialization("configFiles/TC_Config_FV.ini")
    print("Initializing SV Config...")
    SVs = SVLib.initialiseValves("configFiles/SV_Config_FV.ini")
    print("Initializing Reg Config ")
    REGs= DRVLib.initializeRegulators("configFiles/Reg_Config.ini")
    # iniData = telemetry.parseIniFile("configFiles/config.ini", "client")
    
    #readings class
    FVreadings = telemetry.Readings(PTs,TCs)
    #valve state class
    FVstates = telemetry.valveStates(SVs)

    client = clientFunc.Client("configFiles/config.ini", FVreadings, FVstates, REGs)

    with concurrent.futures.ThreadPoolExecutor() as executor:
    
        executor.submit(PTLib.refreshPTs, PTs, client.getPTPoll()) #PT interogation thread
        executor.submit(TCLib.refreshTCs,TCs)#TC interogation thread
        executor.submit(client.runClient)#persistant connection
        executor.submit(client.receiveNExecute)#valve receive and listen

#runs FV_client
main()