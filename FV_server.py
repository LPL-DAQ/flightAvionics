import gui
import serverThreads
import serverFunc


def main():

    #server object
    s = serverFunc.Server("configFiles/config.ini")

    #server threads
    worker1 = serverThreads.dataReceiver(s)
    worker2 = serverThreads.sensorEnforcer(s)
    worker1.start()
    worker2.start()

    #gui thread 
    gui.guiThreadFunc(s) 

main()