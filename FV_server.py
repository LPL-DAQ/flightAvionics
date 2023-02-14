<<<<<<< HEAD
import gui
=======
import telemetry
import timing
import gui
import socket
>>>>>>> dev
import serverThreads
import serverFunc


def main():
    #iniData = telemetry.parseIniFile("configFiles/config.ini", "server")

    s = serverFunc.Server("configFiles/config.ini")
<<<<<<< HEAD
    #worker1 = serverThreads.dataReceiver(s)
    #worker2 = serverThreads.commandSender(s)
    #worker3 = serverThreads.valveTimeOut(s)
    #worker1.start()
    #worker2.start()
    #worker3.start()
=======
    worker1 = serverThreads.dataReceiver(s)
    worker2 = serverThreads.commandSender(s)
    worker3 = serverThreads.valveTimeOut(s)
    worker1.start()
    worker2.start()
    worker3.start()
>>>>>>> dev

    #console thread 
    gui.guiThreadFunc(s) 

#runs server function
main()