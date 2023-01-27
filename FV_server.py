import telemetry
import timing
import gui
import socket
import serverFunc
import server


def main():
    #iniData = telemetry.parseIniFile("configFiles/config.ini", "server")

    s = server.Server("configFiles/config.ini")
    if s == None:
        print("File rejected for the above reasons. Please fix and restart")
        return 0
    worker1 = serverFunc.dataReceiver(s)
    worker2 = serverFunc.commandSender(s)
    worker1.start()
    worker2.start()

    #console thread 
    gui.guiThreadFunc(s) 

#runs server function
main()