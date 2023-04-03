import serverFunc

import time
def console(s:serverFunc.Server):
    consoleToggle = True
    print("Console successfully initialized! ^~^")
    print("Please only resort to using this if the GUI fails")
    while consoleToggle:
        userIn = input(">").strip().lower().split(" ")
        #potential inputs
        if userIn == "print":
            print("Printing sensor data. Press any key to stop")
            time.sleep(1)
        elif userIn == "kill":
            print("")
        elif userIn == "help":
            print("Printing all possible commands...view README for more details")
            print("===========================================")
            print("print")
            print("kill")
            print("help")
            print("===========================================")
        elif userIn == ""

        else:
            print("WARNING: Unrecognized Command. Type <help> to see all console commands")

