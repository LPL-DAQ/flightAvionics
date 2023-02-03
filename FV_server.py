import gui
import serverThreads
import serverFunc


def main():
    #iniData = telemetry.parseIniFile("configFiles/config.ini", "server")

    s = serverFunc.Server("configFiles/config.ini")
    #worker1 = serverThreads.dataReceiver(s)
    #worker2 = serverThreads.commandSender(s)
    #worker3 = serverThreads.valveTimeOut(s)
    #worker1.start()
    #worker2.start()
    #worker3.start()

    #console thread 
    gui.guiThreadFunc(s) 

#runs server function
main()